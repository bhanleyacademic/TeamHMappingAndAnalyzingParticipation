from rest_framework.permissions import BasePermission


class IsNotImpersonating(BasePermission):
    """Block billing actions when an admin is impersonating a user.

    We use JWT auth (not Django sessions), so django-impersonate's
    request.impersonator is never set. Instead we inspect the JWT payload
    for the impersonator_id claim injected by impersonate_start().
    """
    message = 'This action cannot be performed while impersonating a user.'

    def has_permission(self, request, view):
        if not request.auth:
            return True
        return not bool(request.auth.get('impersonator_id'))


class IsAdminRole(BasePermission):
    """Allow access only to users with role='admin'."""
    message = 'Admin role required.'

    def has_permission(self, request, view):
        return bool(
            request.user and
            request.user.is_authenticated and
            request.user.role == 'admin'
        )


class IsSubscribed(BasePermission):
    """Allow access if the user has an active paid subscription.

    Also passes when the site-wide free_tier_override flag is enabled
    (toggled by admins via /api/v1/admin/site-settings/).
    """
    message = 'An active subscription is required to access this feature.'

    def has_permission(self, request, view):
        from apps.api.site_settings import is_free_tier_override
        if is_free_tier_override():
            return bool(request.user and request.user.is_authenticated)
        user = request.user
        if not user or not user.is_authenticated:
            return False
        try:
            return user.subscription.status in ('active', 'trialing')
        except Exception:
            return False
