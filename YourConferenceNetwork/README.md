# YourConference.Network

**Visualize who attends your conferences, how sectors connect, and which organizations anchor your network.**

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Python](https://img.shields.io/badge/Python-3.12-blue.svg)](https://python.org)
[![Django](https://img.shields.io/badge/Django-6.0-092E20.svg)](https://djangoproject.com)

**Cloud hosted:** [yourconference.network](https://yourconference.network) — join the waitlist  
**Self-hosted:** Run with Docker in 5 minutes (see below) — free forever, MIT license

---

## What It Does

Upload your conference attendance CSV and instantly get:

- **Interactive analytics dashboard** — top organizations, sector distribution, event rankings
- **Three network maps** — org–event bipartite, org–org co-attendance, and a 3-layer event → sector → org hierarchy
- **Participation frequency chart** — attendance per event by sector over time (Plotly, interactive)
- **Data quality report** — missing data detection, SNA category normalization
- **CSV exports** — nodes and edges ready for [Kumu.io](https://kumu.io) and [Gephi](https://gephi.org)
- **Flexible filtering** — filter every view by year, sector, or state

---

## Quick Start (Self-Hosted with Docker)

```bash
# 1. Clone the repo
git clone https://github.com/your-org/yourconference.network
cd yourconference.network

# 2. Configure environment
cp .env.example .env
# Edit .env and set a strong SECRET_KEY

# 3. Start the app
docker compose up -d

# 4. Load your attendance CSV
docker compose exec web python manage.py load_data --csv /data/your_conferences.csv
```

Open http://localhost:8000 — done.

See [SELF_HOSTING.md](SELF_HOSTING.md) for detailed setup, CSV format spec, and deployment to a public server.

---

## CSV Format

Your attendance CSV should have these columns:

| Column | Required | Description |
|--------|----------|-------------|
| `UniqueID` | Yes | Unique identifier per attendance record |
| `First` | Yes | First name |
| `Last` | Yes | Last name |
| `Organization - CLEANED` | Yes | Organization name (cleaned) |
| `SNA Category - CLEANED` | Yes | Sector category (see normalization below) |
| `Conference` | Yes | Conference identifier (e.g. `05/2005`) |
| `Month` | Yes | Numeric month (1–12) |
| `Year` | Yes | 4-digit year |
| `State` | Optional | State code for geographic filtering |
| `Organization - ORIGINAL` | Optional | Raw organization name before cleaning |
| `Title - CLEANED` | Optional | Job title |

### SNA Categories

The platform normalizes raw sector labels to 11 canonical categories:

`Program`, `Resource`, `College`, `Intermediary`, `Business`, `T/MC`, `Government`, `K-12 School`, `Faith`, `Foundation`, `Other`

Raw labels like `"program/faith"`, `"intemediary"`, `"cps"` are automatically mapped. See `apps/core/sna_normalize.py` for the full mapping — add custom mappings there.

---

## Tech Stack

- **Backend**: Django 6.0, Python 3.12, SQLite (self-hosted) / PostgreSQL (cloud)
- **Analytics**: Plotly (interactive charts), NetworkX + Matplotlib (network maps)
- **Frontend**: Bootstrap 5 (Runok template), vanilla CSS
- **Deployment**: Docker, Gunicorn, WhiteNoise

---

## Project Structure

```
yourconference.network/
├── apps/
│   ├── core/          # Analytics engine: models, views, charts, network maps, exports
│   └── marketing/     # Marketing site: landing pages, waitlist, contact form
├── config/
│   └── settings/
│       ├── base.py        # Shared settings
│       └── selfhosted.py  # Self-hosted SQLite settings
├── templates/
│   ├── core/          # Analytics app templates
│   └── marketing/     # Marketing site templates
├── static/runok/      # Runok Bootstrap 5 CSS/JS assets
├── requirements/
│   ├── base.txt       # Core dependencies
│   └── selfhosted.txt # Self-hosted (adds nothing beyond base)
├── docker-compose.yml
├── Dockerfile
└── SELF_HOSTING.md
```

---

## Development Setup

```bash
# Create and activate a virtual environment
python -m venv .venv
source .venv/bin/activate   # Windows: .venv\Scripts\activate

# Install dependencies
pip install -r requirements/selfhosted.txt

# Configure environment
cp .env.example .env
export DJANGO_SETTINGS_MODULE=config.settings.selfhosted

# Run migrations and load sample data
python manage.py migrate
python manage.py load_data --csv /path/to/your_conferences.csv

# Start the dev server
python manage.py runserver
```

---

## License

MIT — see [LICENSE](LICENSE). Use it, modify it, host it, redistribute it.

---

## Cloud Hosting

Want a managed version with no setup, automatic updates, and web-based CSV upload?  
Join the waitlist at [yourconference.network](https://yourconference.network).

---

## Contributing

PRs welcome. Open an issue first for significant changes.
