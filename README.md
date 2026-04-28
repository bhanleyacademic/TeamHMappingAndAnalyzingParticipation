# Team H — Mapping and Analyzing Participation

This repository contains two web applications built for Indiana University's ENGR-E483 course. Both are designed so that future teams can pick them up, run them, and extend them without needing to rebuild anything from scratch.

---

## For Future Teams

[Future Suggestions](/ProjectFiles/future_team_suggestions.pdf) (As of submission 4/28/26)

---

## What Is in This Repo

**MappingAndAnalyzingParticipation** is a read-only analytics dashboard for a fixed conference attendance dataset. It loads data from a CSV on startup and lets you explore participation trends through network maps, demographic charts, and search.

**YourConferenceNetwork** is the next step. It is a full web application where any organization can create an account, upload their own conference attendance CSV, and get the same network maps and analytics generated for their data.

---

## Getting Started

You only need [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed. No Python, no database setup, nothing else.

### Mapping and Analyzing Participation

```bash
git clone https://github.com/bhanleyacademic/TeamHMappingAndAnalyzingParticipation.git
cd TeamHMappingAndAnalyzingParticipation/MappingAndAnalyzingParticipation
cp .env.example .env
docker compose up
```

Open http://localhost. The app loads conference data automatically on first run.

### Your Conference Network

```bash
git clone https://github.com/bhanleyacademic/TeamHMappingAndAnalyzingParticipation.git
cd TeamHMappingAndAnalyzingParticipation/YourConferenceNetwork
docker compose up
```

Open http://localhost:8000. Register an account to get started.

---

## Using Mapping and Analyzing Participation

The top navigation has four sections.

**Overview** — participation counts and sector breakdowns by year.

**Network Map** — an interactive graph of organizational connections. Filter by year, sector, or state using the controls at the top.

**Demographics** — charts breaking down attendance by sector, state, and organization type.

**Search** — look up any organization to see its full attendance history across all conference years.

### Filters

Every page supports URL-level filters that can be combined.

- `?year=2019` — filter to a single year
- `?sector=Government` — filter to a sector
- `?state=IN` — filter to a state

Example: `http://localhost/?year=2019&sector=Government`

### Data Export

Use the Export button on any view to download a CSV of the filtered records, or node and edge files for Kumu or Gephi.

---

## Using Your Conference Network

### Creating an Account

Go to http://localhost:8000, register, and log in. You will land on your personal dashboard.

### Uploading Data

1. Click **Upload Dataset** from the dashboard
2. Select a CSV file with conference attendance records
3. Give it a name and submit
4. The app processes the file and marks it Ready when the network is built

### Exploring Your Network

Click into any Ready dataset to access:

**Overview** — total attendees, unique organizations, and year range.

**Network Map** — interactive graph with year, sector, and state filters.

**Demographics** — charts by sector, state, and organization type.

**Search** — look up any organization across your dataset.

### Exporting Data

Use the Export button on any dataset view to download a CSV or node and edge files.

---

## Running in Production

Both apps can be deployed to a server with a single command. See the README inside each project folder for full configuration details and production setup instructions.

- `MappingAndAnalyzingParticipation/README.md`
- `YourConferenceNetwork/README.md`

---

## Project Structure

```
TeamHMappingAndAnalyzingParticipation/
├── MappingAndAnalyzingParticipation/   Django app, fixed dataset, Docker-ready
├── YourConferenceNetwork/              Django app, multi-tenant, Docker-ready
└── ProjectFiles/                       Research outputs, scripts, presentation materials
```
