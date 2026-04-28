#!/bin/sh
set -e

if [ "${1}" != "celery" ]; then
    echo "Running migrations..."
    python manage.py migrate --noinput

    if [ "$DJANGO_SETTINGS_MODULE" = "yourconferencenetwork.settings.production" ]; then
        echo "Collecting static files..."
        python manage.py collectstatic --noinput
    fi
fi

exec "$@"
