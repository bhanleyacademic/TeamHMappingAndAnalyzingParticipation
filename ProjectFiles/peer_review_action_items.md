# Peer Review Action Items — Team H
Consolidated from all three peer reviews received for the intermediate submission.
Organized by target document so changes can be applied independently.

---

## Cross-Document (fix everywhere before final submission)

- [ ] **Record count mismatch** — intermediate report says **6,410** records; client project
  paper says **6,428**. Pick the authoritative number (verify against the loaded database)
  and make every document agree.
- [ ] **SNA variant count mismatch** — intermediate report and one document say **73**;
  presentation says **"~70"**. Standardize to the exact number.
- [ ] **Sponsor name spelling** — "Bassill" (two l's) is correct. The client project paper
  uses "Bassil" (one l) in at least one place. Find and replace all instances.
- [ ] **PowerBI dashboard** — mentioned in the intermediate report but absent from both
  the client project paper and the presentation. Either document it consistently across
  all three, or remove the reference from the intermediate report.

---

## Client Project Paper

### Section 2.2
- [ ] Remove future-tense language: "Timothy will standardize" casing inconsistencies.
  Normalization has already been completed in `sna_normalize.py` — update to past tense
  to reflect work actually done.

### Section 3 (Tool Justification)
- [ ] Add a brief explanation for **why Django was chosen** over simpler alternatives
  (standalone script, Jupyter notebook). Tie the justification to reproducibility and
  the explicit goal of handing the pipeline to future teams. This is obvious from the
  live app but the paper needs to state it.
- [ ] Clean up the rough patches in Section 3 where placeholder language is mixed with
  real content.

### Section 4.2
- [ ] Replace `[Sketch to be updated when received]` with an actual screenshot or
  embedded visualization. The live chart is at `/chart/` — take a screenshot from there.

### Section 6
- [ ] This section is still entirely future-tense placeholder:
  *"At this stage of the project, analysis and visualization are planned but not yet executed."*
  Replace with the actual findings already documented in the intermediate report:
  - Program sector dominance (~50% of all attendance records)
  - Peak attendance in 1999 (565 records)
  - Sharp decline from 2010 onward
  - Dense core of long-term participants vs. large periphery of single-event attendees

### Blank Organization Records
- [ ] State explicitly how the 272 blank organization records (4.2%) are currently handled
  in the visualizations: excluded, grouped as "Unknown," or included as-is. Multiple
  reviewers flagged this; readers and the client will want to know.

### Limitations Section
- [ ] Add a discussion of the dataset cutoff: conferences only go to 2015, so the network
  map does not reflect more than a decade of subsequent activity. Note what this means
  for the client's current use of the tool.

### Visualization Write-ups
- [ ] After each visualization, add a brief concluding sentence explaining what the chart
  tells the client and what action they could take based on it (not just what it shows).

### Evaluation / Validation Section
- [ ] Strengthen the evaluation description: specify who evaluated the platform beyond
  the project sponsor, how many people participated, and what the methodology was.
  Right now it reads as a summary of feedback received rather than a structured evaluation.

---

## Presentation Slides

### Slide 5
- [ ] Replace `[INSERT SCREENSHOT]` placeholder with the actual Plotly chart screenshot.
  The live chart is at `/chart/`.

---

## Intermediate Report / General Report

### Length / Structure
- [ ] Report may exceed the 3-page maximum for the assignment rubric — condense or
  confirm an exception was granted. One approach: separate by audience (client-facing
  content vs. student/developer content; move purely technical details to the README).

### Visualization Framework Image
- [ ] Improve the framework image by adding screenshots or graphic symbols/variables,
  using terminology consistent with the course curriculum, and showing the familiar
  visualization design flow more closely.

### Tools & Workflows Section
- [ ] Remove descriptions of intuitively named CSV exports and filenames — reviewers
  noted these are self-explanatory from the project files and add length without value.

### Deployment Section
- [ ] Replace the mention of "pushing to GitHub" (which can be assumed) with a note
  that future students need basic Git knowledge (add / commit / push) to use the workflow.
  Move any further deployment detail into the README.

### Validation / Redesign Section
- [ ] Condense into a couple of focused paragraphs on the key design influences rather
  than enumerating every item. Maintains depth while improving the reading experience.

### Network Analysis Methodology
- [ ] Document the specific parameter choices:
  - How edges between nodes are weighted (e.g., shared-conference co-attendance count)
  - What similarity threshold is used (or planned) for fuzzy string matching when
    enriching organization URLs

### Insights Discussion
- [ ] Go deeper on interpretation — reviewers noted patterns are identified but not
  explained. Add analysis of:
  - Why Faith and Foundation sectors have very low representation
  - What geographic attendance data outside of Chicago indicates
  - What the 2010 decline implies for Bassill's outreach strategy

### Long Sentences
- [ ] Several sentences in the analysis section are noted as too long. Review and split
  for readability.

---

## README (suggested additions)
- [ ] Move detailed deployment steps (server setup, environment variables, PostgreSQL
  migration) out of the report and into the README, per reviewer suggestion.
- [ ] Add a note that basic Git proficiency (add / commit / push) is a prerequisite for
  contributing to this project.
