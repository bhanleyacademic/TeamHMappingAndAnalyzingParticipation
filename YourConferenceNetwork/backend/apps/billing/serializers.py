from rest_framework import serializers
from .models import SubscriptionPlan, Subscription


class SubscriptionPlanSerializer(serializers.ModelSerializer):
    class Meta:
        model = SubscriptionPlan
        fields = [
            'id', 'name', 'price_monthly', 'max_datasets', 'max_records_per_dataset',
            'can_export_kumu', 'can_export_csv', 'can_view_network_maps', 'stripe_price_id',
        ]


class SubscriptionSerializer(serializers.ModelSerializer):
    plan = SubscriptionPlanSerializer(read_only=True)

    class Meta:
        model = Subscription
        fields = ['status', 'plan', 'current_period_end', 'cancel_at_period_end']
