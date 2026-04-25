#!/bin/sh
set -e

mkdir -p /app/data

echo "Running migrations..."
python manage.py migrate --noinput

echo "Checking for data..."
# Auto-load if a CSV is present at /app/data/conference_data.csv and DB is empty
if [ -f /app/data/conference_data.csv ]; then
    python manage.py load_data --csv /app/data/conference_data.csv
fi

echo "Starting server..."
exec gunicorn config.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 2 \
    --timeout 120
