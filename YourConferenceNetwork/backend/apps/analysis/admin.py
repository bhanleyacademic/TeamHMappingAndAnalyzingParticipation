from django.contrib import admin
from django.contrib import messages
from .models import Dataset, Attendance


@admin.action(description='Re-process selected datasets (re-ingest CSV with current category_map)')
def reingest_datasets(modeladmin, request, queryset):
    from .tasks import process_upload
    count = 0
    for dataset in queryset.filter(status__in=['ready', 'error']):
        dataset.status = 'pending'
        dataset.save(update_fields=['status'])
        process_upload.delay(dataset.id)
        count += 1
    messages.success(request, f'Queued {count} dataset(s) for re-processing.')


@admin.register(Dataset)
class DatasetAdmin(admin.ModelAdmin):
    list_display = ['name', 'user', 'status', 'row_count', 'unique_orgs', 'created_at']
    list_filter = ['status']
    search_fields = ['name', 'user__email']
    readonly_fields = ['created_at', 'updated_at', 'row_count', 'unique_orgs', 'unique_events']
    fields = [
        'user', 'name', 'uploaded_file', 'status', 'error_message',
        'row_count', 'unique_orgs', 'unique_events', 'year_min', 'year_max',
        'kumu_token', 'category_map', 'is_deleted', 'created_at', 'updated_at',
    ]
    actions = [reingest_datasets]
