# Mapping and Analyzing Participation

A Django web application that maps and visualizes conference attendance data across sectors, states, and years. Data is preloaded from a CSV on startup so the app is ready to use out of the box.

This is one of two projects in the repository. See the root README for an overview of both.

---

## Quick Start with Docker

This is the easiest way to run the app, both locally and on a server. The only requirement is [Docker Desktop](https://www.docker.com/products/docker-desktop/).

```bash
git clone https://github.com/bhanleyacademic/TeamHMappingAndAnalyzingParticipation.git
cd TeamHMappingAndAnalyzingParticipation/MappingAndAnalyzingParticipation
cp .env.example .env
docker compose up
```

The app will be available at http://localhost.

Docker handles migrations, data loading, and the server automatically. No Python installation needed.

---

## Configuration

Open `.env` and update these values before running in production.

| Variable | Description |
|---|---|
| `SECRET_KEY` | A long random string. Never share this. |
| `DEBUG` | Leave as `False` in production. Set to `True` only for local debugging. |
| `ALLOWED_HOSTS` | Comma-separated list of allowed hostnames, e.g. `yourdomain.com` |

To generate a secure secret key, run this once and paste the result into `.env`.

```bash
python -c "import secrets; print(secrets.token_urlsafe(50))"
```

---

## Dev Setup Without Docker

If you prefer running locally without Docker, you need Python 3.12 and `make`.

```bash
git clone https://github.com/bhanleyacademic/TeamHMappingAndAnalyzingParticipation.git
cd TeamHMappingAndAnalyzingParticipation/MappingAndAnalyzingParticipation
make setup
make run
```

The app will be available at http://127.0.0.1:8000.

Other useful commands:

- `make reload` — wipe and reload data from the source CSV without touching the schema
- `make clean` — full reset, removes the venv and database

---

## Using the App

### Navigation

The main navigation has four sections.

**Overview** — summary statistics by year with participation counts and sector breakdowns.

**Network Map** — an interactive graph showing connections between organizations. Use the year, sector, and state filters at the top to narrow the view.

**Demographics** — bar and pie charts breaking down attendance by sector, state, and organization type.

**Search** — search for a specific organization to see its full attendance history across all conference years.

### Filters

Every dashboard page supports three filters that can be combined in the URL.

- `?year=2019` — filter to a single conference year
- `?sector=Government` — filter to a specific sector category
- `?state=IN` — filter to a specific state

Example: `http://localhost/?year=2019&sector=Government`

### Data Export

Use the Export button on any view to download the filtered attendance records as a CSV, or as node and edge files for use in Kumu or Gephi.

### Regenerating Network Maps

Static network maps are pre-generated and stored in the `network_maps` folder. To regenerate them after a data reload, run:

```bash
python generate_network_maps.py
```
