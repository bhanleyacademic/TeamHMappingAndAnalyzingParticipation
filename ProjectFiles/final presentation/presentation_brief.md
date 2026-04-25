# Final Presentation Brief — Team H
**ENGR-E483/E583 Information Visualization, Spring 2026**
**Presenter:** Matthew Guschwan (+ team)
**Date/Time:** April 28, 2026 — 3:00–5:00 PM, Fine Arts Building Room 102
**Format:** 5 minutes total, 6 required slide topics

---

## Overview

The presentation tells a single story: **we built a repeatable data-to-visualization pipeline** that lets Daniel Bassill (Tutor/Mentor Institute LLC) understand 21 years of conference participation — and that any future team, conference, or researcher can reuse it.

The pipeline is the deliverable. The visualizations are the proof that the pipeline works.

---

## Slide 1 — Title / Team / Client

**Content:**
- Title: *Mapping & Analyzing Participation in Tutor/Mentor Leadership & Networking Conferences*
- Team: Brian Hanley, Matthew Guschwan, Timothy Kelley, Patrick Green
- Course: ENGR-E483/E583 Information Visualization — Indiana University Luddy School
- Client: Daniel F. Bassill, Tutor/Mentor Institute LLC
- Semester: Spring 2026

**Speaker notes (30 sec):**
"Our team built a data pipeline for Daniel Bassill at Tutor/Mentor Institute LLC — an organization that has run leadership conferences for the Chicago youth-services sector since 1994. The dataset covers 21 years of attendance. Our goal was not just to analyze it, but to build something he and future researchers can keep using."

---

## Slide 2 — Stakeholders and Problem

**Content:**
Four stakeholder groups, one sentence each:
1. **Daniel Bassill / Tutor/Mentor Institute LLC** — Needs to understand network structure, identify underrepresented sectors, and demonstrate long-term impact to funders.
2. **Conference participants and peer organizations** — Need to see who else is in the network and who is missing.
3. **Researchers and students** — Need a reproducible pipeline they can extend (next semester: OHATS integration).
4. **General public / funders** — Need to verify that the conference network actually spans the sectors it claims to.

**Speaker notes (30 sec):**
"Bassill's core question is: who should be in this network, and are they here? Our tool makes that question answerable and repeatable as new data arrives."

---

## Slide 3 — Dataset and Scale

**Content (bullet list):**
- **6,410** participation records
- **2,161** unique organizations
- **41** conferences, May 1994 – November 2014
- **11** SNA (sector) categories — 69 raw label variants normalized to 11
- **270** records with no organization name (4.2%) — excluded from network exports
- Source: Daniel Bassill's conference attendance spreadsheets, cleaned by Fall 2025 Team K

**Figure to use:** `fig_sna_distribution.png` — horizontal bar chart showing records per SNA category

**Speaker notes (45 sec):**
"The raw spreadsheet had 69 different ways to spell or describe the same 11 organizational categories — things like 'Prog', 'program org', 'Prg' all meaning Program. Timothy built the normalization layer that maps all of those to canonical categories. That's not a small thing — without it, any downstream analysis is wrong. Program-sector organizations make up roughly half the dataset; Foundation and Business organizations are dramatically underrepresented relative to their role in Bassill's strategic vision."

---

## Slide 4 — The Pipeline (Primary Deliverable)

**Content:**
Five-stage pipeline — use `fig_pipeline_diagram.png` as the main visual.

| Stage | What it does |
|-------|-------------|
| 1. Ingest | CSV uploaded → loaded into SQLite database via Django management command |
| 2. Normalize | 69 raw SNA variants → 11 canonical categories (+ 12th Media, confirmed by client) |
| 3. Model | NetworkX builds org-event bipartite graph + org-org co-attendance graph |
| 4. Export | Live JSON/CSV API endpoints for Kumu.io and Gephi import |
| 5. Visualize | Plotly interactive chart + Kumu network maps embedded in the Django web app |

**Speaker notes (60 sec):**
"This is the deliverable. The pipeline takes any conference attendance CSV in the same format and produces the same outputs — the charts, the network map, the Kumu export — without any rewriting. Brian built the Django app; I added [your component here]; Timothy normalized the SNA categories; Patrick [his contribution]. We also built a generalized version called YourConferenceNetwork that any conference organizer can self-host and run against their own data. The goal was that when a future IU team picks this up — and there will be one — they inherit working infrastructure, not just a PDF."

---

## Slide 5 — Findings / What the Data Shows

**Content:**
Use `fig_attendance_by_year.png` (attendance trend) as primary figure.
Use `fig_underrepresented.png` as secondary figure if time/space allows.

Key findings (bullet points):
- **Peak attendance 1999: 565 records** in a single year — the network's high-water mark
- **Sharp post-2010 decline** correlates with the institutional transition from T/MC to TMI and the financial pressures Bassill described
- **Program sector dominates (~50%)** — no other sector exceeds ~10% of all records
- **Foundation (55 records), Business (128), Faith (118)** are chronically absent — sectors Bassill explicitly identifies as essential partners
- **Dense core + large periphery**: a cluster of organizations attended 10+ conferences over 21 years; the majority attended once and never returned

Use `fig_network_coattendance.png` if you want to show the network structure visually. The node size = total conference attendances; edges connect orgs that co-attended at least one conference.

**Speaker notes (90 sec):**
"The attendance chart tells a story of growth, a peak, and a decline. The 2010 drop isn't noise — it lines up with the organization's internal transition. The underrepresentation finding is actionable: Bassill can use this to target outreach at Foundation and Business organizations who should be in the network but aren't showing up. And the core-periphery structure tells him which organizations have been with him for decades versus which ones showed up once. Those are three different conversations he needs to have, and now he has data to start them."

---

## Slide 6 — Links / Handoff / Next Steps

**Content:**
- **Live app:** [Brian will provide the local or deployed URL]
- **GitHub repo:** [Brian will provide the link before the presentation]
- **Kumu network map:** [Brian will provide the live Kumu link — use the remote-JSON import URL, not a static PNG]
- **tutormentorexchange.net** — Bassill's strategy documentation
- **Next semester:** OHATS integration — Organization Health Assessment Tool & Survey data (1998–2002 archive cleaned and documented; see `OHATS_path_forward.pdf`)
- **YourConferenceNetwork** — generalized version ready to deploy

**Speaker notes (30 sec):**
"Everything is live. The app, the exports, the Kumu maps. We also spent time documenting the OHATS archive — a 1998–2002 assessment tool Bassill built — so that the next team has a clear starting point. The path forward is connected: attendance data tells you who showed up; OHATS data would tell you what they did when they got there."

---

## Timing Budget

| Slide | Target time |
|-------|------------|
| 1 — Title | 0:30 |
| 2 — Stakeholders | 0:30 |
| 3 — Dataset | 0:45 |
| 4 — Pipeline | 1:00 |
| 5 — Findings | 1:30 |
| 6 — Links / Handoff | 0:30 |
| **Total** | **4:45** |

Leave ~15 seconds of buffer. Do not rush Slide 4 (the pipeline) — that is the core contribution.

---

## Figures in This Folder

| File | Use on slide |
|------|-------------|
| `fig_pipeline_diagram.png` | Slide 4 (main visual) |
| `fig_sna_distribution.png` | Slide 3 |
| `fig_attendance_by_year.png` | Slide 5 (primary) |
| `fig_underrepresented.png` | Slide 5 (secondary / if space) |
| `fig_network_coattendance.png` | Slide 5 or Slide 6 (network structure) |

---

## Things to Confirm with Brian Before Building Slides

1. **Live app URL** — he needs to confirm the server is up and provide the URL for Slide 6.
2. **GitHub repo URL** — confirm the link is finalized and the repo is public.
3. **Kumu live map link** — get the remote-JSON Kumu URL (not a static image).
4. **Your and Patrick's contributions** — fill in the Slide 4 speaker notes where it says "[your component here]" and "[his contribution]".
5. **Screenshot of the Plotly `/chart/` page** — if you want to include it on Slide 5 alongside the static charts, ask Brian to screenshot it from the running app.

---

## Style Notes

- Use a clean, minimal slide theme — no heavy backgrounds. These charts have color already.
- Keep bullet points to one line each. The speaker notes carry the explanation.
- If your slide software supports it, set figures to full-bleed (edge to edge) on Slides 3–5.
- The required 6 topics per the rubric are: (1) title/team, (2) stakeholders, (3) data, (4) methods/pipeline, (5) results/findings, (6) future work/links. This brief maps to those exactly.
