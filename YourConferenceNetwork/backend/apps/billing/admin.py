from django.contrib import admin
from .models import SubscriptionPlan, Subscription


@admin.register(SubscriptionPlan)
class SubscriptionPlanAdmin(admin.ModelAdmin):
    list_display = ['name', 'price_monthly', 'max_datasets', 'can_export_kumu', 'is_active']
    ordering = ['display_order']


@admin.register(Subscription)
class SubscriptionAdmin(admin.ModelAdmin):
    list_display = ['user', 'plan', 'status', 'current_period_end']
    list_filter = ['status']
    search_fields = ['user__email', 'stripe_customer_id']
    readonly_fields = ['created_at', 'updated_at']
