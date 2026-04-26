from django.db import models


class SiteSettings(models.Model):
    """Singleton row — always access via objects.get_or_create(pk=1).
    Controls site-wide feature flags toggled by admins without a deploy.
    """
    free_tier_override = models.BooleanField(
        default=False,
        help_text=(
            'When True, all authenticated users pass IsSubscribed checks. '
            'Use during beta / before Stripe is live.'
        ),
    )
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = 'Site Settings'

    def __str__(self):
        return f'SiteSettings (free_tier_override={self.free_tier_override})'
