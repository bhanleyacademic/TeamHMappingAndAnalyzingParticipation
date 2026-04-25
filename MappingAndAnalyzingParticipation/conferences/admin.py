from django.contrib import admin
from .models import Attendance


@admin.register(Attendance)
class AttendanceAdmin(admin.ModelAdmin):
    list_display = ("unique_id", "first_name", "last_name", "organization", "sna_category", "conference", "year")
    list_filter = ("sna_category", "year", "state")
    search_fields = ("first_name", "last_name", "organization", "sna_category_original")
