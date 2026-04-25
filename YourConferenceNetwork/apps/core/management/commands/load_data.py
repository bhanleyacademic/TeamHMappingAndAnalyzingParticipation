"""
Management command: load conference CSV into the database.

Usage:
    python manage.py load_data
    python manage.py load_data --csv /path/to/file.csv
    python manage.py load_data --clear   # wipe existing rows first
"""

import csv
from pathlib import Path

from django.conf import settings
from django.core.management.base import BaseCommand, CommandError

from apps.core.models import Attendance
from apps.core.sna_normalize import normalize

DEFAULT_CSV = Path(settings.BASE_DIR) / "data" / "conference_data.csv"


def _clean_zip(raw: str) -> str:
    """Normalize ZIP to 5 digits; keep blank if missing."""
    z = raw.strip().split("-")[0].strip()
    return z.zfill(5) if z.isdigit() else z[:10]


def _safe_int(val: str):
    try:
        return int(val.strip())
    except (ValueError, AttributeError):
        return None


class Command(BaseCommand):
    help = "Load conference participation CSV into the Attendance table."

    def add_arguments(self, parser):
        parser.add_argument(
            "--csv",
            default=str(DEFAULT_CSV),
            help="Path to the cleaned conference CSV file.",
        )
        parser.add_argument(
            "--clear",
            action="store_true",
            help="Delete all existing Attendance rows before loading.",
        )

    def handle(self, *args, **options):
        csv_path = Path(options["csv"])
        if not csv_path.exists():
            raise CommandError(f"CSV not found: {csv_path}")

        if not options["clear"] and Attendance.objects.exists():
            self.stdout.write("Data already loaded — skipping. Use --clear to reload.")
            return

        if options["clear"]:
            deleted, _ = Attendance.objects.all().delete()
            self.stdout.write(f"Cleared {deleted} existing rows.")

        rows_created = 0

        with csv_path.open(newline="", encoding="utf-8-sig") as fh:
            reader = csv.DictReader(fh)
            batch = []
            for row in reader:
                raw_sna = row.get("SNA Category - CLEANED", "").strip()
                org_cleaned = row.get("Organization - CLEANED", "").strip()
                org_original = row.get("Organization - ORIGINAL", "").strip()

                batch.append(
                    Attendance(
                        unique_id=_safe_int(row.get("UniqueID", "0")) or 0,
                        salutation=row.get("Salutation", "").strip(),
                        first_name=row.get("First", "").strip(),
                        last_name=row.get("Last", "").strip(),
                        sna_category_original=raw_sna,
                        sna_category=normalize(raw_sna),
                        title=row.get("Title - CLEANED", row.get("Title", "")).strip(),
                        organization_original=org_original,
                        organization=org_cleaned or org_original,
                        active_inactive=row.get("Active / Inactive", "").strip(),
                        address=row.get("Address", "").strip(),
                        city=row.get("City", "").strip(),
                        state=row.get("State", "").strip(),
                        zip_code=_clean_zip(row.get("Zip", "")),
                        conference=row.get("Conference", "").strip(),
                        month=_safe_int(row.get("Month", "")),
                        year=_safe_int(row.get("Year", "")),
                    )
                )

                if len(batch) >= 500:
                    Attendance.objects.bulk_create(batch)
                    rows_created += len(batch)
                    batch = []

            if batch:
                Attendance.objects.bulk_create(batch)
                rows_created += len(batch)

        self.stdout.write(
            self.style.SUCCESS(f"Loaded {rows_created} attendance records.")
        )
