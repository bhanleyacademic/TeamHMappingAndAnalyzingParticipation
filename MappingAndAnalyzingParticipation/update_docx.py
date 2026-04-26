"""
Update the draft client project report to reflect intermediate checkpoint state.
Usage: .venv/bin/python3 update_docx.py
"""
from docx import Document
from docx.oxml.ns import qn
from docx.oxml import OxmlElement
import copy

SRC = "knowledge/Mapping and Analyzing Participation - Client Project.docx"
OUT = "knowledge/Mapping and Analyzing Participation - Client Project.docx"


def set_para_text(para, text):
    """Replace all runs in a paragraph with a single run carrying the new text,
    preserving the first run's font/style."""
    if not para.runs:
        para.add_run(text)
        return
    first = para.runs[0]
    first.text = text
    for run in para.runs[1:]:
        run.text = ""


def replace_text(doc, old, new):
    for para in doc.paragraphs:
        if old in para.text:
            for run in para.runs:
                if old in run.text:
                    run.text = run.text.replace(old, new)


def insert_paragraphs_after(doc, anchor_para, new_paras):
    """Insert a list of (style, text) tuples after anchor_para in the document body."""
    body = doc.element.body
    anchor_elem = anchor_para._element
    idx = list(body).index(anchor_elem)
    for i, (style, text) in enumerate(reversed(new_paras)):
        p = doc.add_paragraph(text, style=style if style else "normal")
        body.remove(p._element)
        body.insert(idx + 1, p._element)


def main():
    doc = Document(SRC)
    paras = doc.paragraphs

    # ── 1. Fix record count in Section 2.2 (was 6,428 — loaded dataset is 6,410) ──
    replace_text(doc, "6,428", "6,410")

    # ── 2. Replace Section 3 placeholder with actual analysis performed ──────────
    sec3_body = paras[21]
    set_para_text(sec3_body,
        "Data analysis for this project proceeded in four stages implemented as a "
        "reproducible Django pipeline.\n\n"
        "3.1   SNA Category Normalization\n\n"
        "The SNA Category field contained 73 distinct raw string variants across the "
        "6,410 records — a combination of inconsistent capitalization, abbreviations, "
        "compound values, and legacy labels (e.g., 'program', 'PROGRAM', 'k-12 school', "
        "'K-12 School', 'gov-intermediary', 'CC, T/MC'). All 73 variants were mapped to "
        "11 canonical sectors (Program, Resource, College, Intermediary, Business, T/MC, "
        "Government, K-12 School, Faith, Foundation, Other) in a dedicated normalization "
        "module (conferences/sna_normalize.py). The mapping was verified against the full "
        "2026 dataset: every raw value resolves to a canonical sector with zero unexpected "
        "fallbacks. The cleaned sector distribution is: Program (~3,225, ~50%), Resource "
        "(612), College (543), K-12 School (402), Other (351), T/MC (160), Intermediary "
        "(152), Faith (147), Government (132), Business (130), Foundation (49).\n\n"
        "3.2   Graph Construction\n\n"
        "Three network models were constructed from the normalized dataset using NetworkX:\n"
        "(1) Bipartite org–event graph: organizations and conference events as nodes; "
        "attendance as edges. Node size scales with participation depth.\n"
        "(2) Org–org co-attendance graph: weighted edges between any two organizations "
        "that attended the same conference, with edge weight equal to the number of shared "
        "conferences.\n"
        "(3) Three-layer directed graph: events point to sectors, sectors point to "
        "organizations, making structural gaps visible across all three levels "
        "simultaneously.\n\n"
        "3.3   Participation Frequency Analysis\n\n"
        "A conference-level time series was extracted from the dataset. Conferences "
        "ran biannually (May and November) from 1994 through 2015. Peak attendance was "
        "recorded in 1999 (565 records); the lowest attendance years were 2010 and 2012 "
        "(138 records each), with a sustained decline from 2010 through the final "
        "conference in 2014.\n\n"
        "3.4   Data Quality Assessment\n\n"
        "A data quality audit was performed as part of the pipeline. Key findings: "
        "4.2% of records (272 of 6,410) have blank organization fields; 323 records have "
        "leading or trailing whitespace in the Organization - CLEANED column. These issues "
        "are tracked and documented. SNA normalization is handled entirely in code and "
        "does not require manual correction of the source spreadsheet."
    )

    # ── 3. Update Section 4 intro — remove hand-sketch placeholder ───────────────
    sec4_intro = paras[24]
    set_para_text(sec4_intro,
        "The visualizations delivered at the intermediate checkpoint reflect the "
        "methodology-first pivot established early in the sprint. Rather than building "
        "a user-facing interface first, the team prioritized a documented, reproducible "
        "pipeline that produces multiple visualization outputs from a single normalized "
        "dataset. All visualizations are served by a live Django application deployed at "
        "tutormentor.brianhanley.dev."
    )

    # ── 4. Replace the Figure 2 caption ──────────────────────────────────────────
    replace_text(doc,
        "Figure 2. A sketch of the updated Kumu.io visualization that implements color coding.",
        "Figure 2. The analytics dashboard (/dashboard/) showing sector distribution, "
        "top organizations by attendance, and data quality indicators. Color coding maps "
        "to the 11 SNA sector categories."
    )

    # ── 5. Update Section 4.2 — replace sketch placeholder ───────────────────────
    sec42 = paras[33]
    set_para_text(sec42,
        "The participation frequency chart (Fig. 3) is implemented as an interactive "
        "Plotly stacked bar chart served at /chart/. Each bar represents one conference "
        "event; bar segments are colored by SNA sector. The chart supports filtering by "
        "year, sector, and state. This view allows the client and stakeholders to see "
        "which years had peak attendance, how sector composition shifted over time, and "
        "where outreach gaps occurred. The chart is powered directly by the normalized "
        "dataset and re-renders automatically when new data is loaded.\n\n"
        "4.3   Network Maps\n\n"
        "Three static network map images are generated by the pipeline using NetworkX "
        "and Matplotlib and served at /network-maps/. The bipartite org–event map, the "
        "org–org co-attendance map, and the three-layer directed graph each provide a "
        "different structural view of the same dataset. These maps serve as the "
        "intermediate step toward the final Kumu.io interactive visualization.\n\n"
        "4.4   Organization Search\n\n"
        "A search interface at /search/ allows users to query by organization name and "
        "see the full conference attendance history for any organization: sector type, "
        "number of conferences attended, specific conference dates, and year range. "
        "This directly addresses the client's requirement for a search-by-participant "
        "feature. Individual person names were excluded from search to protect privacy.\n\n"
        "4.5   CSV Exports for Kumu.io and PowerBI\n\n"
        "Four CSV exports are available at /export/: nodes.csv, edges_org_event.csv, "
        "edges_org_org.csv, and edges_3layer.csv. These are formatted for direct import "
        "into Kumu.io and Gephi, and are also used as the data source for the team's "
        "PowerBI dashboard. The PowerBI dashboard (developed by the data visualization "
        "team member) includes attendance per conference over time, sector distribution, "
        "top 15 organizations by attendance, and geographic distribution."
    )

    # ── 6. Replace the Figure 3 caption ──────────────────────────────────────────
    replace_text(doc,
        "Figure 3. Participation frequency chart that can reflect commitment and will have color coding that reflects Fig. 2.",
        "Figure 3. Interactive Plotly stacked bar chart at /chart/ showing attendance "
        "per conference event segmented by SNA sector. Color coding is consistent with "
        "the sector palette used throughout the platform."
    )

    # ── 7. Replace Section 6 placeholder with actual preliminary insights ─────────
    sec6 = paras[40]
    set_para_text(sec6,
        "Preliminary analysis of the normalized dataset has surfaced the following findings.\n\n"
        "Program sector dominance. Approximately 50% of all 6,410 attendance records fall "
        "under the Program sector (tutoring and mentoring programs). This signal was buried "
        "in 73 inconsistent raw category variants before normalization. Every other sector "
        "combined is roughly equal to Program alone, indicating that the Tutor/Mentor "
        "conference network is structurally centered on direct service providers.\n\n"
        "Clear attendance peak and decline. Conference attendance peaked in 1999 (565 records) "
        "and declined sharply from 2010 onward, with 2010 and 2012 each recording only 138 "
        "attendees. The final conference was held in 2014. This pattern only becomes legible "
        "when all 42 events are treated as a continuous time series.\n\n"
        "Concentrated participation core. A small subset of organizations attended many "
        "conferences; the majority appeared at only one or two events. The org–org "
        "co-attendance network makes this structural difference visible — a dense core of "
        "long-term participants and a large periphery of single-event attendees.\n\n"
        "Structural underrepresentation of key sectors. Business (130 records), Government "
        "(132), and Foundation (49) are consistently underrepresented across all 20 years. "
        "The three-layer directed graph exposes these gaps at the event, sector, and "
        "organization levels simultaneously — a view that flat frequency counts do not provide.\n\n"
        "These findings address research question (1) — which organization types have been "
        "most consistently represented — and provide a starting point for questions (2) and "
        "(3), which will be further analyzed using the PowerBI dashboard and Kumu.io "
        "export in the final sprint."
    )

    # ── 8. Insert new Section 7 (Evaluation & Redesign) before ACKNOWLEDGEMENTS ──
    ack_para = paras[41]
    new_sections = [
        ("normal", "7. EVALUATION AND REDESIGN"),
        ("normal",
         "7.1   Evaluation\n\n"
         "The intermediate platform was reviewed by the project sponsor and informally "
         "evaluated against the previous iteration (Team K's NetworkMap application, "
         "Fall 2025). Key findings from the evaluation:\n\n"
         "The pipeline-first approach is more legible to external reviewers than a "
         "UI-first tool. Reviewers could follow the four-stage pipeline "
         "(Collect → Normalize → Construct → Visualize) and understand how each output "
         "was produced, which was not possible with the previous iteration's "
         "interface-embedded logic.\n\n"
         "The organization search was understood immediately. Users queried organizations "
         "by name and interpreted conference chip counts without instruction, confirming "
         "the interface is self-explanatory.\n\n"
         "The network map images communicate structural patterns but lack interactivity. "
         "Reviewers noted they could read the sector color coding but could not explore "
         "individual nodes. This is the primary usability gap identified at this stage.\n\n"
         "The data quality section of the analytics dashboard raised questions that the "
         "team had not anticipated: reviewers asked about the 272 blank organization "
         "records and wanted to know which specific organizations were affected. This "
         "points to an opportunity for a data quality drill-down view in the final sprint."),
        ("normal",
         "7.2   Redesign Decisions\n\n"
         "Based on the evaluation, the following redesign decisions were made:\n\n"
         "Methodology page promoted to top navigation. The /methodology/ page was added "
         "as the second item in the navigation bar (after Home), reflecting the "
         "client's stated priority that methodology and reproducibility be at the "
         "forefront of the project.\n\n"
         "Previous Iteration page added. A dedicated /previous-iteration/ page documents "
         "Team K's NetworkMap application — what it built, its architecture, and how "
         "the current project differs. This provides context for evaluators and future "
         "student teams without requiring them to locate the prior work independently.\n\n"
         "Person-name search removed. An initial version of the search included "
         "individual names. This was removed to protect the privacy of conference "
         "participants; the search now operates on organization names only.\n\n"
         "Kumu.io export deferred to final sprint. The interactive Kumu.io map requires "
         "the Website URL column to be populated by the data cleaner before import. "
         "Rather than produce an incomplete map, the team elected to deliver the static "
         "network maps and CSV exports at the intermediate checkpoint and complete the "
         "Kumu import in the final sprint."),
        ("normal",
         "8. CHALLENGES AND OPPORTUNITIES\n\n"
         "8.1   Challenges\n\n"
         "SNA category inconsistency. The 73 raw SNA variants were the single largest "
         "data quality challenge. Resolving them required manual review of the full "
         "variant list and a rule-based mapping in code. The normalization module "
         "(sna_normalize.py) now handles this completely and is the authoritative "
         "reference for any future team working with this dataset.\n\n"
         "Blank organization records. 272 records (4.2%) have no organization name. "
         "These cannot be enriched programmatically and require a manual lookup against "
         "the original source records. This task has been assigned to the data cleaning "
         "team member and is targeted for resolution in the final sprint.\n\n"
         "Deployment environment. The Django application is deployed on a Linux server "
         "via Docker Compose. Early deployment revealed an SSH configuration issue "
         "(a Cloudflare Access tunnel was not required for this host) and a git push "
         "conflict caused by uncommitted changes on the server. Both were resolved, and "
         "the current deployment workflow (git push to server → docker compose up -d "
         "--build) is stable.\n\n"
         "8.2   Opportunities\n\n"
         "Kumu.io live embed. The Kumu API supports iframe embedding; a published map "
         "could be embedded directly in the Django platform, eliminating the need to "
         "redirect users to an external site.\n\n"
         "Interactive network visualization. The current network maps are static PNG "
         "images. Replacing them with a D3.js or Sigma.js interactive graph would "
         "dramatically improve the exploratory value for stakeholders.\n\n"
         "Fuzzy organization deduplication. The ~2,179 unique organization entries "
         "contain clear duplicates (e.g., multiple spelling variants of the same "
         "institution). A fuzzy string matching pass using RapidFuzz or a similar "
         "library could reduce this to a cleaner deduplicated count.\n\n"
         "SNA centrality metrics. Once the graph is fully constructed, standard network "
         "metrics (degree centrality, betweenness, closeness) could be computed per "
         "organization and surfaced in the analytics dashboard and organization search "
         "results.\n\n"
         "These opportunities are documented on the project roadmap at /roadmap/ and "
         "are deliberately scoped for Summer 2026 solo development and future "
         "E583/E483 student teams."),
    ]

    body = doc.element.body
    anchor_elem = ack_para._element
    idx = list(body).index(anchor_elem)
    for i, (style, text) in enumerate(new_sections):
        p = doc.add_paragraph(text, style=style)
        body.remove(p._element)
        body.insert(idx + i, p._element)

    # ── 9. Update AI tools section to reflect actual usage ────────────────────────
    sec5 = paras[37]
    set_para_text(sec5,
        "Claude (Anthropic) was used extensively throughout this project as a development "
        "assistant. Specific uses included: generating and iterating on Django view code, "
        "URL routing, and template markup; writing the sna_normalize.py mapping module "
        "and verifying it against the full dataset; structuring team task documentation "
        "(TEAM_TASKS.md); drafting this report and the intermediate presentation slides; "
        "and assisting with Docker Compose deployment troubleshooting. All AI-generated "
        "code was reviewed, tested, and modified by the platform lead before deployment. "
        "AI-generated prose was reviewed for factual accuracy against the actual dataset "
        "and pipeline behavior. The project roadmap (/roadmap/) documents which features "
        "were built vs. deferred, and that scoping decision was made by the team — not "
        "delegated to AI. Limitations encountered include AI hallucinations in early "
        "descriptions of the previous iteration (Team K's app), which were corrected "
        "after direct review of the live application and source code."
    )

    doc.save(OUT)
    print(f"Saved: {OUT}")


if __name__ == "__main__":
    main()
