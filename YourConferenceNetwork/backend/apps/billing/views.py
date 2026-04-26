import stripe
from django.conf import settings
from django.views.decorators.csrf import csrf_exempt
from rest_framework import status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework.response import Response

from apps.api.permissions import IsNotImpersonating
from .models import SubscriptionPlan, Subscription
from .serializers import SubscriptionPlanSerializer, SubscriptionSerializer


@api_view(['GET'])
@permission_classes([AllowAny])
def plan_list(request):
    plans = SubscriptionPlan.objects.filter(is_active=True)
    return Response(SubscriptionPlanSerializer(plans, many=True).data)


@api_view(['GET'])
@permission_classes([IsAuthenticated])
def subscription_detail(request):
    try:
        sub = request.user.subscription
    except Subscription.DoesNotExist:
        return Response({'status': 'free', 'plan': None, 'current_period_end': None})
    return Response(SubscriptionSerializer(sub).data)


@api_view(['POST'])
@permission_classes([IsAuthenticated, IsNotImpersonating])
def checkout(request):
    """Create a Stripe Checkout session and return the redirect URL."""
    price_id = request.data.get('price_id')
    if not price_id:
        return Response({'detail': 'price_id is required.'}, status=status.HTTP_400_BAD_REQUEST)

    stripe.api_key = settings.STRIPE_SECRET_KEY
    try:
        session = stripe.checkout.Session.create(
            customer_email=request.user.email,
            payment_method_types=['card'],
            line_items=[{'price': price_id, 'quantity': 1}],
            mode='subscription',
            success_url=request.build_absolute_uri('/app/billing/success?session_id={CHECKOUT_SESSION_ID}'),
            cancel_url=request.build_absolute_uri('/app/billing/plans'),
            # Store both user_id and price_id so the webhook can link plan → subscription
            metadata={'user_id': str(request.user.id), 'price_id': price_id},
        )
        return Response({'url': session.url})
    except stripe.error.StripeError as e:
        return Response({'detail': str(e)}, status=status.HTTP_502_BAD_GATEWAY)


@api_view(['POST'])
@permission_classes([IsAuthenticated, IsNotImpersonating])
def portal(request):
    """Create a Stripe Customer Portal session."""
    stripe.api_key = settings.STRIPE_SECRET_KEY
    try:
        sub = request.user.subscription
        if not sub.stripe_customer_id:
            return Response({'detail': 'No Stripe customer linked.'}, status=status.HTTP_400_BAD_REQUEST)
        session = stripe.billing_portal.Session.create(
            customer=sub.stripe_customer_id,
            return_url=request.build_absolute_uri('/app/billing/plans'),
        )
        return Response({'url': session.url})
    except (Subscription.DoesNotExist, stripe.error.StripeError) as e:
        return Response({'detail': str(e)}, status=status.HTTP_502_BAD_GATEWAY)


@csrf_exempt
@api_view(['POST'])
@permission_classes([AllowAny])
def stripe_webhook(request):
    """Handle Stripe webhook events. Signature is verified; no JWT auth."""
    stripe.api_key = settings.STRIPE_SECRET_KEY
    payload = request.body
    sig_header = request.META.get('HTTP_STRIPE_SIGNATURE', '')

    try:
        event = stripe.Webhook.construct_event(payload, sig_header, settings.STRIPE_WEBHOOK_SECRET)
    except (ValueError, stripe.error.SignatureVerificationError):
        return Response({'detail': 'Invalid signature.'}, status=status.HTTP_400_BAD_REQUEST)

    _handle_webhook_event(event)
    return Response({'received': True})


def _handle_webhook_event(event):
    import datetime
    from django.contrib.auth import get_user_model
    User = get_user_model()

    if event['type'] == 'checkout.session.completed':
        session = event['data']['object']
        meta = session.get('metadata', {})
        user_id = meta.get('user_id')
        price_id = meta.get('price_id', '')
        if not user_id:
            return
        try:
            user = User.objects.get(pk=user_id)
        except User.DoesNotExist:
            return
        # Look up plan by the price_id stored in metadata (session.subscription is a sub ID, not price)
        plan = SubscriptionPlan.objects.filter(stripe_price_id=price_id).first()
        # Fetch full subscription from Stripe to get current_period_end
        stripe_sub_id = session.get('subscription', '')
        period_end = None
        if stripe_sub_id:
            try:
                stripe_sub = stripe.Subscription.retrieve(stripe_sub_id)
                ts = stripe_sub.get('current_period_end')
                if ts:
                    period_end = datetime.datetime.fromtimestamp(ts, tz=datetime.timezone.utc)
            except stripe.error.StripeError:
                pass
        Subscription.objects.update_or_create(
            user=user,
            defaults={
                'stripe_customer_id': session.get('customer', ''),
                'stripe_subscription_id': stripe_sub_id,
                'status': 'active',
                'plan': plan,
                'current_period_end': period_end,
            },
        )

    elif event['type'] in ('customer.subscription.updated', 'customer.subscription.deleted'):
        stripe_sub = event['data']['object']
        try:
            sub = Subscription.objects.get(stripe_subscription_id=stripe_sub['id'])
        except Subscription.DoesNotExist:
            return
        sub.status = stripe_sub['status']
        sub.cancel_at_period_end = stripe_sub.get('cancel_at_period_end', False)
        if stripe_sub.get('current_period_end'):
            sub.current_period_end = datetime.datetime.fromtimestamp(
                stripe_sub['current_period_end'], tz=datetime.timezone.utc
            )
        sub.save()
