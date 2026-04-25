from django.db import models


class WaitlistEntry(models.Model):
    email = models.EmailField(unique=True)
    org_name = models.CharField(max_length=255, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name_plural = "waitlist entries"
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.email} ({self.org_name or 'no org'})"
