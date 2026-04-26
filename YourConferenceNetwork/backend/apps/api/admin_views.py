import logging
from django.contrib.auth import get_user_model
from django.shortcuts import get_object_or_404
from rest_framework import status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework_simplejwt.tokens import RefreshToken

from apps.accounts.serializers import UserSerializer
from apps.api.models import SiteSettings
from apps.api.site_settings import invalidate_site_settings_cache
from .permissions import IsAdminRole

logger = logging.getLogger('impersonation')

User = get_user_model()


@api_view(['GET'])
@permission_classes([IsAuthenticated, IsAdminRole])
def user_list(request):
    users = User.objects.select_related('profile').order_by('-date_joined')
    return Response(UserSerializer(users, many=True).data)


@api_view(['GET'])
@permission_classes([IsAuthenticated, IsAdminRole])
def user_detail(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    return Response(UserSerializer(user).data)


@api_view(['POST'])
@permission_classes([IsAuthenticated, IsAdminRole])
def impersonate_start(request, user_id):
    """
    Issue a special JWT for the impersonated user that carries an
    'impersonator_id' claim. The Vue SPA reads this claim to show the
    impersonation banner and disable billing UI.
    """
    target_user = get_object_or_404(User, pk=user_id)
    if target_user.is_superuser:
        return Response({'detail': 'Cannot impersonate superusers.'}, status=status.HTTP_403_FORBIDDEN)

    refresh = RefreshToken.for_user(target_user)
    # Embed the admin's identity so the frontend can detect impersonation
    refresh['impersonator_id'] = request.user.id
    refresh['impersonator_email'] = request.user.email
    refresh['role'] = target_user.role
    refresh['email'] = target_user.email

    logger.warning(
        'Impersonation started: admin=%s (%d) → user=%s (%d)',
        request.user.email, request.user.id, target_user.email, target_user.id
    )
    return Response({
        'access': str(refresh.access_token),
        'refresh': str(refresh),
        'impersonating': {
            'id': target_user.id,
            'email': target_user.email,
            'firstName': target_user.first_name,
            'lastName': target_user.last_name,
        },
    })


@api_view(['GET', 'PATCH'])
@permission_classes([IsAuthenticated, IsAdminRole])
def site_settings(request):
    """GET returns current site settings; PATCH updates free_tier_override."""
    obj, _ = SiteSettings.objects.get_or_create(pk=1)
    if request.method == 'PATCH':
        val = request.data.get('free_tier_override')
        if val is not None:
            obj.free_tier_override = bool(val)
            obj.save()
            invalidate_site_settings_cache()
            logger.warning(
                'free_tier_override set to %s by %s (%d)',
                val, request.user.email, request.user.id,
            )
    return Response({
        'free_tier_override': obj.free_tier_override,
        'updated_at': obj.updated_at,
    })


@api_view(['POST'])
@permission_classes([IsAuthenticated])
def impersonate_stop(request):
    """
    The Vue SPA calls this when the admin clicks 'Stop impersonating'.
    Returns fresh tokens for the original admin account.
    """
    impersonator_id = request.auth.get('impersonator_id') if request.auth else None
    if not impersonator_id:
        return Response({'detail': 'Not currently impersonating.'}, status=status.HTTP_400_BAD_REQUEST)

    admin_user = get_object_or_404(User, pk=impersonator_id)
    refresh = RefreshToken.for_user(admin_user)
    refresh['role'] = admin_user.role
    refresh['email'] = admin_user.email

    logger.warning(
        'Impersonation ended: admin=%s (%d) ← user=%s (%d)',
        admin_user.email, admin_user.id, request.user.email, request.user.id
    )
    return Response({
        'access': str(refresh.access_token),
        'refresh': str(refresh),
        'user': {
            'id': admin_user.id,
            'email': admin_user.email,
            'firstName': admin_user.first_name,
            'lastName': admin_user.last_name,
            'username': admin_user.username or admin_user.email,
            'role': admin_user.role,
        },
    })
