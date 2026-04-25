# Self-Hosting Guide — YourConference.Network

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/) (v2+)
- Your attendance data as a CSV file

That's it. No database server, no Python, no configuration beyond a secret key.

---

## Quick Start

```bash
# 1. Get the code
git clone https://github.com/your-org/yourconference.network
cd yourconference.network

# 2. Set up environment
cp .env.example .env

# Edit .env — at minimum, set a strong SECRET_KEY:
# python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())"
```

Edit `.env`:
```
SECRET_KEY=your-long-random-secret-key-here
DEBUG=False
ALLOWED_HOSTS=localhost,127.0.0.1
```

```bash
# 3. Start the app
docker compose up -d

# 4. Copy your CSV into the data volume, then load it
cp /path/to/my_conferences.csv ./data/conference_data.csv
docker compose exec web python manage.py load_data --csv /app/data/conference_data.csv

# 5. Open http://localhost:8000
```

**Optional shortcut:** If you copy your CSV to `data/conference_data.csv` before running `docker compose up`, it will be loaded automatically on first start.

---

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `SECRET_KEY` | Yes | — | Django secret key. Generate with `get_random_secret_key()` |
| `DEBUG` | No | `False` | Set to `True` only for local development |
| `ALLOWED_HOSTS` | No | `localhost,127.0.0.1` | Comma-separated list of allowed hostnames |
| `EMAIL_BACKEND` | No | Console (prints to logs) | Set to SMTP backend for real email |
| `EMAIL_HOST` | No | — | SMTP server hostname |
| `EMAIL_PORT` | No | — | SMTP port (587 for TLS) |
| `EMAIL_USE_TLS` | No | — | `True` for TLS |
| `EMAIL_HOST_USER` | No | — | SMTP username |
| `EMAIL_HOST_PASSWORD` | No | — | SMTP password or API key |
| `DEFAULT_FROM_EMAIL` | No | `noreply@yourconference.network` | From address for outgoing email |
| `CONTACT_EMAIL` | No | `hello@yourconference.network` | Destination for contact form submissions |

---

## CSV Format

Your CSV must be UTF-8 encoded (UTF-8-BOM is also supported). Required columns:

| Column Name | Description |
|-------------|-------------|
| `UniqueID` | Unique integer per attendance record |
| `First` | First name |
| `Last` | Last name |
| `Organization - CLEANED` | Organization name (primary name used in analysis) |
| `SNA Category - CLEANED` | Sector category label (see normalization below) |
| `Conference` | Conference identifier string, e.g. `05/2005` for May 2005 |
| `Month` | Numeric month (1–12) |
| `Year` | 4-digit year |

Optional columns (used if present):
- `Organization - ORIGINAL` — original unclean org name (for audit trail)
- `Title - CLEANED` — job title
- `Salutation` — Mr./Ms./Dr. etc.
- `State` — 2-letter state code (enables geographic filtering)
- `Address`, `City`, `Zip` — for location context
- `Active / Inactive` — participation status

### SNA Category Normalization

The platform maps raw sector labels to 11 canonical categories automatically:

| Canonical | Example raw values |
|-----------|--------------------|
| Program | `program`, `program/faith`, `peogram` |
| Resource | `resource` |
| College | `college`, `university`, `student` |
| Intermediary | `intermediary`, `intemediary`, `intergenerational` |
| Business | `business`, `business/foundation` |
| T/MC | `t/mc`, `cc-t/mc`, `tm-network` |
| Government | `government`, `gov-intermediary` |
| K-12 School | `k-12 school`, `cps`, `public school` |
| Faith | `faith` |
| Foundation | `foundation`, `legal/foundation` |
| Other | Everything else |

To add custom mappings for your dataset, edit `apps/core/sna_normalize.py` and add entries to `_RAW_MAP`.

---

## Loading Data

```bash
# Load from a specific path (inside the container)
docker compose exec web python manage.py load_data --csv /app/data/myfile.csv

# Clear existing data and reload
docker compose exec web python manage.py load_data --csv /app/data/myfile.csv --clear

# Check how many records loaded
docker compose exec web python manage.py shell -c "from apps.core.models import Attendance; print(Attendance.objects.count())"
```

---

## Deploying to a Public Server

### With a Domain Name

1. Point your domain's DNS A record to your server's IP
2. Update `.env`:
   ```
   ALLOWED_HOSTS=yourconference.yourdomain.org
   DEBUG=False
   ```
3. Set up Nginx as a reverse proxy in front of port 8000
4. Use Certbot to get a free SSL certificate

### Recommended Hosts

Any VPS with Docker support works. $5–10/month options:
- [Hetzner](https://hetzner.com) — excellent price/performance
- [DigitalOcean](https://digitalocean.com)
- [Vultr](https://vultr.com)

---

## Upgrading

```bash
# Pull latest code
git pull

# Rebuild and restart
docker compose up -d --build

# Migrations run automatically on startup
```

Your data in the `db_data` Docker volume is preserved across upgrades.

---

## Backups

The SQLite database lives in the `db_data` Docker volume:

```bash
# Create a backup
docker compose exec web sqlite3 /app/data/db.sqlite3 ".backup /app/data/backup-$(date +%Y%m%d).db"

# Copy backup to host
docker compose cp web:/app/data/backup-*.db ./backups/
```

---

## Want Managed Hosting?

Running your own server is free and gives you full control. But if you'd prefer
someone else to handle updates, backups, and uptime, join the cloud hosting waitlist at
[yourconference.network](https://yourconference.network).
