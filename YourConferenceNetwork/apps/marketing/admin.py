from django.contrib import admin
from .models import WaitlistEntry


@admin.register(WaitlistEntry)
class WaitlistEntryAdmin(admin.ModelAdmin):
    list_display = ('email', 'org_name', 'created_at')
    search_fields = ('email', 'org_name')
    ordering = ('-created_at',)
