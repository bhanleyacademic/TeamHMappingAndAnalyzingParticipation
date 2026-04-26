import logging
from celery import shared_task

logger = logging.getLogger(__name__)


@shared_task(bind=True, max_retries=3)
def process_upload(self, dataset_id):
    """
    Celery task: ingest a user's uploaded CSV and run the analysis pipeline.
    Sets dataset.status to 'processing' → 'ready' (or 'error' on failure).
    """
    from .models import Dataset
    from .pipeline.ingest import ingest_csv

    try:
        dataset = Dataset.objects.get(pk=dataset_id)
    except Dataset.DoesNotExist:
        logger.error('process_upload: Dataset %d not found', dataset_id)
        return

    dataset.status = 'processing'
    dataset.save(update_fields=['status'])

    try:
        row_count = ingest_csv(dataset)
        dataset.status = 'ready'
        dataset.row_count = row_count
        # Compute summary stats
        from .models import Attendance
        qs = Attendance.objects.filter(dataset=dataset)
        dataset.unique_orgs = qs.values('organization').distinct().count()
        dataset.unique_events = qs.values('conference').distinct().count()
        years = qs.values_list('year', flat=True).exclude(year__isnull=True)
        if years:
            dataset.year_min = min(years)
            dataset.year_max = max(years)
        dataset.save()
        logger.info('process_upload: Dataset %d ready (%d rows)', dataset_id, row_count)
    except Exception as exc:
        logger.exception('process_upload: Dataset %d failed: %s', dataset_id, exc)
        dataset.status = 'error'
        dataset.error_message = str(exc)
        dataset.save(update_fields=['status', 'error_message'])
        raise self.retry(exc=exc, countdown=60)
