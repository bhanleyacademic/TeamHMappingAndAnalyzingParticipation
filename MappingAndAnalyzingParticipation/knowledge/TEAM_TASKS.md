# Team Tasks — Spring 2026 Sprint

**Intermediate checkpoint:** Sunday April 5 at 8pm EDT
**Presentation:** Monday April 6, Luddy Hall 1106, 5:30–6:45pm
**Peer feedback due:** Sunday April 12 at 8pm EST (individual submission)

---

## Data Cleaner

### Now → April 5

- [ ] **Trim whitespace from Organization - CLEANED**
  323 entries have leading or trailing spaces. Strip these so the pipeline deduplicates correctly. A find/replace or a short Python/Excel formula handles this in bulk.

- [ ] **Flag or fill blank Organization records**
  272 records (4.2%) have no organization. Go through these and either:
  - Fill from the original source if identifiable
  - Mark with a consistent placeholder (e.g. `[Unknown]`) so they're trackable
  - Document your decision in the draft report

- [ ] **Add Website URL column for top organizations**
  The dataset has no URL field — this is a client requirement from Dan Bassill.
  - Add a new column: `Website`
  - Start with the top 20–30 organizations by total attendance (pull from the Analytics Dashboard → Top Organizations table)
  - Format as full URLs (e.g. `https://example.org`)
  - Even partial coverage is better than none for the April 5 checkpoint

- [ ] **Document data quality decisions in draft report**
  The write-up needs a data cleaning section. Cover:
  - What issues existed in the raw data (SNA variants, blank orgs, whitespace)
  - What was fixed, what was left, and the rationale
  - Note that SNA normalization is handled in code — the spreadsheet values feed into a mapping layer that resolves all 73 raw variants automatically

- [ ] **Export updated CSV and share with platform lead**
  Once cleaning is done, export Sheet1 as CSV and share so the pipeline can reload:
  ```
  make reload
  ```

### April 6 → April 13

- [ ] **Review peer feedback received after April 6 presentation**
  Note any data quality issues or gaps flagged by reviewers — these should be addressed in the final sprint.

- [ ] **Resolve obvious organization name duplicates (start)**
  Begin working through clear duplicates:
  - "Fourth Presbyterian Church..." variants
  - "Epworth Tutoring Program..." variants
  - "YMCA of Chicago..." variants
  Target: reduce from ~2,179 unique org entries to a cleaner deduplicated count.

- [ ] **Expand website URL coverage**
  Extend the Website column beyond the initial 20–30 orgs. Aim for the top 50–60 by the final checkpoint.

---

## PowerBI / Data Visualization

### Now → April 5

The platform exports at `/export/` are PowerBI-ready — download `nodes.csv` and `edges_org_event.csv` from the running app as your data source. The dashboard at `/dashboard/` also has filtered views you can reference for context.

- [ ] **Attendance per conference over time**
  Bar or line chart with conference date on the x-axis and total attendees on y.
  Look for: peak years (2004–2010), decline toward 2014, any gaps.
  This is the most important single chart for the presentation.

- [ ] **Sector distribution — overall**
  Donut or horizontal bar showing the 11 SNA categories by record count.
  Program (~50%) dominates — make sure the chart communicates that clearly while still showing the other sectors.

- [ ] **Sector mix over time**
  Stacked bar or area chart — conferences on x-axis, sector share on y.
  Key question: did sector diversity increase or decrease across 20 years?

- [ ] **Top 15 organizations by total attendance**
  Simple ranked bar chart. Pull from `nodes.csv` (sort by Record_Count descending).

- [ ] **Geographic distribution**
  Map view using City/State columns. Expected result: heavily Chicago/Illinois-centric.
  Note any outliers — who came from outside Illinois?

- [ ] **Active vs. returning organizations**
  Distribution of how many conferences each org attended.
  Categorize as: attended 1, 2–3, 4–6, 7–10, 10+ conferences.
  Shows the difference between one-time visitors and sustained participants.

- [ ] **Export final charts as images**
  Export each chart as PNG or PDF for inclusion in the draft report and presentation slides.

### April 6 → April 13

- [ ] **Incorporate feedback from April 6 presentation**
  Note any visualization critique from instructors or other teams.

- [ ] **Refine sector-over-time chart**
  This is the most analytically rich chart — spend time making it clear and readable.
  Consider: normalize to percentage share rather than raw count so conference size differences don't distort the trend.

- [ ] **Identify 2–3 key insights to highlight in the final report**
  The final write-up needs "actionable insights." Pull specific findings from your charts:
  - Which sectors grew or shrank?
  - Which organizations were most consistent?
  - What does the geographic data tell us about reach?

- [ ] **Begin exploring PowerBI embed options**
  For the summer roadmap item — research whether the PowerBI report can be published and embedded via iframe in the Django platform.

---

## All Team Members

### By April 5
- [ ] Update the Google Drive folder with all current work
- [ ] Submit Canvas link to Google Drive folder by 8pm EDT April 5
- [ ] Be at Luddy Hall 1106 by 5:30pm April 6 for the presentation

### April 6–13
- [ ] **Peer feedback (individual, not group)** — due April 12 at 8pm EST
  Review 2 other teams' work. Submit as Word doc or PDF (not on discussion board).
  Cover all 5 rubric points for each team:
  1. Data selection, cleaning, preparation, and documentation
  2. Appropriateness of tools, algorithms, workflows, and parameters
  3. Quality of data analysis, visualizations, and insight discussion
  4. Completeness and quality of validation and redesign
  5. Overall quality — accuracy, completeness, clarity, references
