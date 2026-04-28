# Your Conference Network

A Django web application that lets organizations upload their own conference attendance data and generate interactive network maps and analytics dashboards. Users get their own account, upload a CSV, and get a full visualization of their participant network.

This is one of two projects in the repository. See the root README for an overview of both.

---

## Quick Start with Docker (Development)

The only requirement is [Docker Desktop](https://www.docker.com/products/docker-desktop/).

```bash
git clone https://github.com/bhanleyacademic/TeamHMappingAndAnalyzingParticipation.git
cd TeamHMappingAndAnalyzingParticipation/YourConferenceNetwork
docker compose up
```

The app will be available at http://localhost:8000.

That is it for local development. Docker uses SQLite and runs background tasks synchronously so there is no Redis or separate worker process to manage.

---

## Quick Start with Docker (Production)

Production uses PostgreSQL and Redis. You need to fill in a `.env` file before starting.

```bash
git clone https://github.com/bhanleyacademic/TeamHMappingAndAnalyzingParticipation.git
cd TeamHMappingAndAnalyzingParticipation/YourConferenceNetwork
cp backend/.env.example backend/.env
```

Open `backend/.env` and fill in all required values (see Configuration below), then run:

```bash
docker compose -f docker-compose.prod.yml up -d
```

The app will be available at http://your-server-ip.

---

## Configuration

Copy `backend/.env.example` to `backend/.env` and fill in these values before running in production.

| Variable | Description |
|---|---|
| `DJANGO_SECRET_KEY` | A long random string. Never share this. |
| `DJANGO_ALLOWED_HOSTS` | Comma-separated list of allowed hostnames, e.g. `yourdomain.com` |
| `DB_NAME` | PostgreSQL database name |
| `DB_USER` | PostgreSQL username |
| `DB_PASSWORD` | PostgreSQL password |
| `STRIPE_SECRET_KEY` | From your Stripe dashboard under API keys |
| `STRIPE_PUBLISHABLE_KEY` | From your Stripe dashboard under API keys |
| `STRIPE_WEBHOOK_SECRET` | From your Stripe webhook settings |

To generate a secure secret key, run this once and paste the result into `.env`.

```bash
python -c "import secrets; print(secrets.token_urlsafe(50))"
```

For production PostgreSQL, uncomment `psycopg2-binary` in `backend/requirements.txt` before building.

---

## Dev Setup Without Docker

If you prefer running locally without Docker, you need Python 3.12.

```bash
git clone https://github.com/bhanleyacademic/TeamHMappingAndAnalyzingParticipation.git
cd TeamHMappingAndAnalyzingParticipation/YourConferenceNetwork/backend
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver
```

The app will be available at http://127.0.0.1:8000.

---

## Using the App

### Creating an Account

Go to http://localhost:8000 and register for an account. After logging in you will land on your dashboard.

### Uploading Data

1. From the dashboard, click **Upload Dataset**
2. Select a CSV file formatted with the expected columns (see the sample CSV in `backend/static/sample_data.csv` if available)
3. Give the dataset a name and submit
4. The app processes the file in the background and notifies you when it is ready

The dataset status will show as Processing and then Ready when the network is built.

### Exploring Your Network

Once a dataset is ready, click into it to access:

**Overview** — summary statistics including total attendees, unique organizations, and year range.

**Network Map** — an interactive graph showing connections between organizations. Filter by year, sector, or state using the dropdowns at the top.

**Demographics** — charts breaking down attendance by sector, state, and organization type.

**Search** — search for a specific organization to see its full attendance history across your dataset.

### Exporting Data

From any dataset view, use the Export button to download the filtered records as a CSV or as node and edge files for use in Kumu or Gephi.

### Admin

The Django admin panel is available at http://localhost:8000/admin. Create a superuser with:

```bash
python manage.py createsuperuser
```

Or inside Docker:

```bash
docker compose exec web python manage.py createsuperuser
```
