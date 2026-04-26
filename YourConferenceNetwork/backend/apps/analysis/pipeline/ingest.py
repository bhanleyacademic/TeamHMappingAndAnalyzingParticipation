"""
CSV ingestion pipeline.

Adapted from MappingAndAnalyzingParticipation/conferences/management/commands/load_data.py.
The management command wrapper is dropped; this is a plain function called by the Celery task.
"""
import csv
import io
from typing import Union

from .normalize import get_normalizer


def _clean_zip(raw: str) -> str:
    z = raw.strip().split('-')[0].strip()
    return z.zfill(5) if z.isdigit() else z[:10]


def _safe_int(val: str):
    try:
        return int(val.strip())
    except (ValueError, AttributeError):
        return None


def _parse_conference_date(conference: str):
    """Parse 'MM/YYYY' into (month, year) ints. Returns (None, None) on failure."""
    parts = conference.strip().split('/')
    if len(parts) == 2:
        return _safe_int(parts[0]), _safe_int(parts[1])
    return None, None


def ingest_csv(dataset, file_obj: Union[None, object] = None) -> int:
    """
    Parse the uploaded CSV file for *dataset* and bulk-insert Attendance records.
    Returns the number of rows created.

    If file_obj is None, re-opens dataset.uploaded_file.
    Clears existing Attendance rows for this dataset before inserting.
    """
    from apps.analysis.models import Attendance

    # Clear any previous attempt
    Attendance.objects.filter(dataset=dataset).delete()

    if file_obj is None:
        raw_bytes = dataset.uploaded_file.read()
    else:
        raw_bytes = file_obj.read()

    # Decode — handle UTF-8 with BOM
    text = raw_bytes.decode('utf-8-sig', errors='replace')
    reader = csv.DictReader(io.StringIO(text))

    _normalize = get_normalizer(dataset.category_map)
    batch = []
    rows_created = 0
    BATCH_SIZE = 500

    for row in reader:
        raw_sna = (
            row.get('SNA Category - CLEANED')
            or row.get('SNA Category - ORIGINAL')
            or row.get('category')
            or ''
        ).strip()
        org_cleaned = row.get('Organization - CLEANED', '').strip()
        org_original = (
            row.get('Organization - ORIGINAL')
            or row.get('name')
            or ''
        ).strip()

        conference = row.get('Conference', '').strip()
        month, year = _parse_conference_date(conference)
        if month is None and year is None:
            # Fallback: explicit Month/Year columns (case-insensitive check for 'year')
            month = _safe_int(row.get('Month') or row.get('month') or '')
            year  = _safe_int(row.get('Year')  or row.get('year')  or '')
            # Build a conference string from year alone if still missing
            if not conference and year:
                conference = str(year)

        batch.append(
            Attendance(
                dataset=dataset,
                unique_id=_safe_int(row.get('UniqueID', '')) or 0,
                salutation=row.get('Salutation', '').strip(),
                first_name=row.get('First', '').strip(),
                last_name=row.get('Last', '').strip(),
                sna_category_original=raw_sna,
                sna_category=_normalize(raw_sna),
                title=row.get('Title - CLEANED', row.get('Title', '')).strip(),
                organization_original=org_original,
                organization=org_cleaned or org_original,
                active_inactive=row.get('Active / Inactive', '').strip(),
                address=row.get('Address', '').strip(),
                city=row.get('City', '').strip(),
                state=row.get('State', '').strip(),
                zip_code=_clean_zip(row.get('Zip', '')),
                website=row.get('Website', row.get('website', '')).strip()[:255],
                conference=conference,
                month=month,
                year=year,
            )
        )

        if len(batch) >= BATCH_SIZE:
            Attendance.objects.bulk_create(batch)
            rows_created += len(batch)
            batch = []

    if batch:
        Attendance.objects.bulk_create(batch)
        rows_created += len(batch)

    return rows_created
