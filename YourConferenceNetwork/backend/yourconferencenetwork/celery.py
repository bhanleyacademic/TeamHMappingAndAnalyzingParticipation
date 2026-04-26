import os
from celery import Celery

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'yourconferencenetwork.settings.development')

app = Celery('yourconferencenetwork')
app.config_from_object('django.conf:settings', namespace='CELERY')
app.autodiscover_tasks()
