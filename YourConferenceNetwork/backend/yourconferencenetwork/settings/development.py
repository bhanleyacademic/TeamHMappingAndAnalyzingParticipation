from .base import *

DEBUG = True

SECRET_KEY = 'django-insecure-dev-only-31^&)29s6o2+z*c7g%pyu3^og5)lb+eglkcgebxj21fi'

ALLOWED_HOSTS = ['localhost', '127.0.0.1', '0.0.0.0']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}

# Allow the Vue dev server and the Django server
CORS_ALLOWED_ORIGINS = [
    'http://localhost:5173',
    'http://127.0.0.1:5173',
    'http://localhost:8000',
]
CORS_ALLOW_CREDENTIALS = True

# Also allow Kumu.io to fetch blueprint JSON
CORS_ALLOWED_ORIGIN_REGEXES = [
    r'^https://.*\.kumu\.io$',
]

# In dev, use the simpler static files storage (no hash manifest)
STATICFILES_STORAGE = 'django.contrib.staticfiles.storage.StaticFilesStorage'

# Show emails in console during development
EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'

# Run Celery tasks synchronously in dev (no Redis required)
CELERY_TASK_ALWAYS_EAGER = True
CELERY_TASK_EAGER_PROPAGATES = True
