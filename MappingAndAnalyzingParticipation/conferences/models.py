from django.db import models


class Attendance(models.Model):
    unique_id = models.IntegerField()
    salutation = models.CharField(max_length=20, blank=True)
    first_name = models.CharField(max_length=100, blank=True)
    last_name = models.CharField(max_length=100, blank=True)
    sna_category_original = models.CharField(max_length=100, blank=True)
    sna_category = models.CharField(max_length=50, blank=True)  # normalized
    title = models.CharField(max_length=200, blank=True)
    organization_original = models.CharField(max_length=200, blank=True)
    organization = models.CharField(max_length=200, blank=True)  # cleaned
    active_inactive = models.CharField(max_length=20, blank=True)
    address = models.CharField(max_length=255, blank=True)
    city = models.CharField(max_length=100, blank=True)
    state = models.CharField(max_length=50, blank=True)
    zip_code = models.CharField(max_length=10, blank=True)
    conference = models.CharField(max_length=20, blank=True)  # e.g. "05/2000"
    month = models.IntegerField(null=True, blank=True)
    year = models.IntegerField(null=True, blank=True)

    class Meta:
        verbose_name_plural = "attendances"
        indexes = [
            models.Index(fields=["year"]),
            models.Index(fields=["sna_category"]),
            models.Index(fields=["organization"]),
        ]

    def __str__(self):
        return f"{self.first_name} {self.last_name} – {self.conference}"
