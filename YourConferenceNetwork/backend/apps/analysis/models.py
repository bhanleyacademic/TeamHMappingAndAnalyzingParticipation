import uuid
from django.conf import settings
from django.db import models


def upload_path(instance, filename):
    return f'uploads/{instance.user.id}/{uuid.uuid4().hex}.csv'


class Dataset(models.Model):
    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('processing', 'Processing'),
        ('ready', 'Ready'),
        ('error', 'Error'),
    ]

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='datasets'
    )
    name = models.CharField(max_length=255)
    uploaded_file = models.FileField(upload_to=upload_path)
    status = models.CharField(max_length=15, choices=STATUS_CHOICES, default='pending')
    error_message = models.TextField(blank=True)
    row_count = models.IntegerField(null=True, blank=True)
    unique_orgs = models.IntegerField(null=True, blank=True)
    unique_events = models.IntegerField(null=True, blank=True)
    year_min = models.IntegerField(null=True, blank=True)
    year_max = models.IntegerField(null=True, blank=True)
    kumu_token = models.UUIDField(default=uuid.uuid4, unique=True, editable=False)
    category_map = models.JSONField(null=True, blank=True)
    is_deleted = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return f'{self.name} ({self.user.email})'


class Attendance(models.Model):
    dataset = models.ForeignKey(Dataset, on_delete=models.CASCADE, related_name='records')

    # Identifiers
    unique_id = models.IntegerField(null=True, blank=True)
    salutation = models.CharField(max_length=20, blank=True)
    first_name = models.CharField(max_length=100, blank=True)
    last_name = models.CharField(max_length=100, blank=True)

    # Category (raw + normalized)
    sna_category_original = models.CharField(max_length=100, blank=True)
    sna_category = models.CharField(max_length=100, blank=True)

    # Title
    title = models.CharField(max_length=255, blank=True)
    title_cleaned = models.CharField(max_length=255, blank=True)

    # Organization (raw + normalized)
    organization_original = models.CharField(max_length=255, blank=True)
    organization = models.CharField(max_length=255, blank=True)

    # Status & location
    active_inactive = models.CharField(max_length=20, blank=True)
    address = models.CharField(max_length=255, blank=True)
    city = models.CharField(max_length=100, blank=True)
    state = models.CharField(max_length=50, blank=True)
    zip_code = models.CharField(max_length=10, blank=True)

    # Website
    website = models.URLField(max_length=255, blank=True)

    # Conference date
    conference = models.CharField(max_length=10, blank=True)  # MM/YYYY
    month = models.IntegerField(null=True, blank=True)
    year = models.IntegerField(null=True, blank=True)

    class Meta:
        indexes = [
            models.Index(fields=['dataset', 'year']),
            models.Index(fields=['dataset', 'sna_category']),
            models.Index(fields=['dataset', 'organization']),
        ]

    def __str__(self):
        return f'{self.organization} @ {self.conference} (dataset {self.dataset_id})'
