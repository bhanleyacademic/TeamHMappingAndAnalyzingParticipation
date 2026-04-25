FROM python:3.12-slim

WORKDIR /app

# Install dependencies first (layer caching)
COPY requirements/base.txt requirements/selfhosted.txt ./requirements/
RUN pip install --no-cache-dir -r requirements/selfhosted.txt

# Copy project source
COPY . .

# Collect static files (use a dummy key at build time only)
RUN SECRET_KEY=build-time-dummy python manage.py collectstatic --noinput

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/docker-entrypoint.sh"]
