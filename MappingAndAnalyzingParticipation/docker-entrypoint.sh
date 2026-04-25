#!/bin/sh
set -e

mkdir -p /app/data

echo "Running migrations..."
python manage.py migrate --noinput

echo "Loading conference data (skipped if already loaded)..."
python manage.py load_data

echo "Starting server..."
exec gunicorn MappingAndAnalyzingParticipation.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 2 \
    --timeout 120
