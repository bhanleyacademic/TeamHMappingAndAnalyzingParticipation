from rest_framework import serializers
from .models import Dataset


class DatasetSerializer(serializers.ModelSerializer):
    class Meta:
        model = Dataset
        fields = [
            'id', 'name', 'uploaded_file', 'status', 'error_message',
            'row_count', 'unique_orgs', 'unique_events', 'year_min', 'year_max',
            'kumu_token', 'category_map', 'created_at', 'updated_at',
        ]
        read_only_fields = [
            'id', 'status', 'error_message', 'row_count', 'unique_orgs',
            'unique_events', 'year_min', 'year_max', 'kumu_token',
            'created_at', 'updated_at',
        ]
