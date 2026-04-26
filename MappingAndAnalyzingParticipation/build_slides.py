"""
Build intermediate presentation PPTX — 6 slides.
Usage: .venv/bin/python build_slides.py
Output: Intermediate_Presentation.pptx
"""

from pptx import Presentation
from pptx.util import Inches, Pt
from pptx.dml.color import RGBColor
from pptx.enum.text import PP_ALIGN

NAVY   = RGBColor(0x1A, 0x3A, 0x5C)
BLUE   = RGBColor(0x15, 0x65, 0xC0)
GREEN  = RGBColor(0x2E, 0x7D, 0x32)
ORANGE = RGBColor(0xE6, 0x51, 0x00)
PURPLE = RGBColor(0x6A, 0x1B, 0x9A)
GREY   = RGBColor(0x54, 0x6E, 0x7A)
WHITE  = RGBColor(0xFF, 0xFF, 0xFF)
LIGHT  = RGBColor(0xEE, 0xF2, 0xF7)
YELLOW = RGBColor(0xF5, 0xA6, 0x23)
TEAL   = RGBColor(0x00, 0x96, 0x88)
LTGRN  = RGBColor(0xE8, 0xF5, 0xE9)
LTBLUE = RGBColor(0xE3, 0xF2, 0xFD)
LTPUR  = RGBColor(0xF3, 0xE5, 0xF5)
LTOR   = RGBColor(0xFF, 0xF3, 0xE0)


def new_prs():
    prs = Presentation()
    prs.slide_width  = Inches(13.33)
    prs.slide_height = Inches(7.5)
    return prs


def blank(prs):
    return prs.slides.add_slide(prs.slide_layouts[6])


def box(slide, x, y, w, h, fill=None):
    s = slide.shapes.add_shape(1, Inches(x), Inches(y), Inches(w), Inches(h))
    s.line.fill.background()
    if fill:
        s.fill.solid(); s.fill.fore_color.rgb = fill
    else:
        s.fill.background()
    return s


def tx(slide, text, x, y, w, h, sz=16, bold=False, col=NAVY,
        align=PP_ALIGN.LEFT, italic=False, wrap=True):
    tb = slide.shapes.add_textbox(Inches(x), Inches(y), Inches(w), Inches(h))
    tb.word_wrap = wrap
    tf = tb.text_frame; tf.word_wrap = wrap
    p = tf.paragraphs[0]; p.alignment = align
    r = p.add_run(); r.text = text
    r.font.size = Pt(sz); r.font.bold = bold
    r.font.color.rgb = col; r.font.italic = italic
    return tb


def buls(slide, items, x, y, w, h, sz=14, col=NAVY, sub=None):
    tb = slide.shapes.add_textbox(Inches(x), Inches(y), Inches(w), Inches(h))
    tb.word_wrap = True
    tf = tb.text_frame; tf.word_wrap = True
    for i, item in enumerate(items):
        text, lvl = (item, 0) if isinstance(item, str) else item
        p = tf.paragraphs[0] if i == 0 else tf.add_paragraph()
        p.level = lvl; p.space_before = Pt(2)
        r = p.add_run(); r.text = text
        r.font.size  = Pt(sz if lvl == 0 else sz - 2)
        r.font.color.rgb = (sub or GREY) if lvl > 0 else col


def hdr(slide, label, title, sub=None):
    """Slide number pill + title bar."""
    box(slide, 0, 0, 13.33, 1.05, fill=NAVY)
    box(slide, 0, 0, 0.55, 1.05, fill=BLUE)
    tx(slide, label, 0.05, 0.2, 0.5, 0.65, sz=22, bold=True,
       col=WHITE, align=PP_ALIGN.CENTER)
    tx(slide, title, 0.65, 0.08, 11.5, 0.62, sz=26, bold=True, col=WHITE)
    if sub:
        tx(slide, sub, 0.65, 0.7, 11.5, 0.35, sz=12, col=LIGHT, italic=True)


# ── SLIDE 1 · Title / Intro ───────────────────────────────────────────────────
def s1_title(prs):
    s = blank(prs)
    box(s, 0, 0, 13.33, 7.5, fill=NAVY)
    box(s, 0, 0, 13.33, 0.18, fill=YELLOW)
    box(s, 0, 7.32, 13.33, 0.18, fill=YELLOW)
    box(s, 0, 4.9, 13.33, 2.42, fill=BLUE)

    tx(s, "Mapping & Analyzing Participation",
       0.45, 0.55, 12.4, 1.05, sz=40, bold=True, col=WHITE, align=PP_ALIGN.CENTER)
    tx(s, "Intermediate Results  —  Spring 2026",
       0.45, 1.65, 12.4, 0.55, sz=20, col=LIGHT, align=PP_ALIGN.CENTER, italic=True)

    # Divider line
    box(s, 2.0, 2.38, 9.33, 0.05, fill=YELLOW)

    tx(s, "Client:  Daniel F. Bassill  ·  Tutor/Mentor Connection (T/MC)",
       0.45, 2.55, 12.4, 0.45, sz=16, col=LIGHT, align=PP_ALIGN.CENTER)
    tx(s, "E583 / E483 Information Visualization  ·  Indiana University  ·  April 6, 2026",
       0.45, 3.02, 12.4, 0.4, sz=13, col=LIGHT, align=PP_ALIGN.CENTER, italic=True)

    # Photo placeholders — 3 equal columns
    photo_y = 3.65; photo_h = 1.0; photo_w = 1.0
    positions = [2.17, 4.8, 7.42]  # adjusted for 3 centered
    labels = ["[ Photo ]", "[ Photo ]", "[ Photo ]"]
    roles  = ["Platform Lead", "Data Cleaner", "Data Visualization"]
    names  = ["Team Member", "Team Member", "Team Member"]
    affil  = "Indiana University"
    for i, (px, lbl, role, name) in enumerate(zip(positions, labels, roles, names)):
        box(s, px, photo_y, photo_w, photo_h, fill=GREY)
        tx(s, lbl, px, photo_y+0.32, photo_w, 0.38,
           sz=10, col=LIGHT, align=PP_ALIGN.CENTER, italic=True)
        tx(s, name, px-0.25, photo_y+photo_h+0.06, photo_w+0.5, 0.3,
           sz=11, bold=True, col=WHITE, align=PP_ALIGN.CENTER)
        tx(s, role, px-0.25, photo_y+photo_h+0.38, photo_w+0.5, 0.28,
           sz=10, col=LIGHT, align=PP_ALIGN.CENTER)
        tx(s, affil, px-0.25, photo_y+photo_h+0.65, photo_w+0.5, 0.25,
           sz=9, col=LIGHT, align=PP_ALIGN.CENTER, italic=True)


# ── SLIDE 2 · Stakeholder & Needs ────────────────────────────────────────────
def s2_stakeholder(prs):
    s = blank(prs)
    hdr(s, "2", "Stakeholder & Needs",
        "Daniel F. Bassill · Tutor/Mentor Connection (T/MC)")

    # Left: who
    box(s, 0.3, 1.15, 6.1, 0.42, fill=NAVY)
    tx(s, "Who is the Stakeholder?", 0.4, 1.18, 5.9, 0.38,
       sz=14, bold=True, col=WHITE)
    buls(s, [
        "Daniel F. Bassill — founder, Tutor/Mentor Connection",
        "Hosted 42 Leadership & Networking Conferences, 1994–2015",
        "Builds coalitions between schools, nonprofits, business, and government to support youth mentoring in Chicago",
        "tutormentorexchange.net",
    ], 0.35, 1.62, 6.0, 2.4, sz=13)

    box(s, 0.3, 4.15, 6.1, 0.42, fill=NAVY)
    tx(s, "What problem are we solving?", 0.4, 4.18, 5.9, 0.38,
       sz=14, bold=True, col=WHITE)
    buls(s, [
        "20+ years of conference attendance data exists but has never been fully analyzed",
        "No system exists to visualize who participated, how often, or across which sectors",
        "The data is the evidence base for Dan's network-building work",
    ], 0.35, 4.62, 6.0, 2.5, sz=13)

    # Divider
    box(s, 6.6, 1.1, 0.05, 5.9, fill=LIGHT)

    # Right: what they need
    box(s, 6.7, 1.15, 6.28, 0.42, fill=BLUE)
    tx(s, "What the Client Needs", 6.8, 1.18, 6.1, 0.38,
       sz=14, bold=True, col=WHITE)
    needs = [
        "Kumu.io network map updated with full 1994–2015 dataset",
        "Organization search — full conference attendance history",
        "Color-coded by sector type with filtering capability",
        "Website addresses for participating organizations",
        "Explanatory section on how to read the Kumu map",
        "Links to Tutor/Mentor program lists for cross-reference",
        "Documented, reproducible methodology",
    ]
    y = 1.68
    for need in needs:
        box(s, 6.7, y, 0.28, 0.28, fill=BLUE)
        tx(s, "›", 6.72, y+0.01, 0.28, 0.28, sz=14, bold=True,
           col=WHITE, align=PP_ALIGN.CENTER)
        tx(s, need, 7.05, y+0.02, 5.9, 0.32, sz=12, col=NAVY)
        y += 0.42

    box(s, 0, 6.85, 13.33, 0.65, fill=LIGHT)
    tx(s, "Core question: Who shows up to build a community — and what patterns emerge across 20 years?",
       0.35, 6.94, 12.6, 0.38, sz=13, bold=True, col=NAVY, align=PP_ALIGN.CENTER)


# ── SLIDE 3 · Data & Dashboard ───────────────────────────────────────────────
def s3_dashboard(prs):
    s = blank(prs)
    hdr(s, "3", "Data & Visualization — PowerBI Dashboard",
        "6,410 records · 42 conferences · 1994–2015 · 11 SNA sectors · 2,179 organizations")

    # Large screenshot placeholder — left 2/3
    box(s, 0.28, 1.18, 8.5, 5.55, fill=RGBColor(0xDD, 0xE3, 0xEA))
    tx(s, "[ Insert PowerBI Dashboard Screenshot ]",
       0.28, 3.55, 8.5, 0.55, sz=14, col=GREY,
       align=PP_ALIGN.CENTER, italic=True)

    # Right column: 6 stat cards
    stats = [
        ("6,410",  "attendance records",  NAVY),
        ("42",     "conference events",   BLUE),
        ("21 yrs", "1994 – 2015",         GREEN),
        ("11",     "SNA sectors",         PURPLE),
        ("2,179",  "unique organizations",ORANGE),
        ("~50%",   "Program sector share",TEAL),
    ]
    x = 9.08; y = 1.18
    for val, lbl, color in stats:
        box(s, x, y, 4.0, 0.82, fill=color)
        tx(s, val, x+0.12, y+0.04, 1.8, 0.42,
           sz=22, bold=True, col=WHITE)
        tx(s, lbl, x+0.12, y+0.46, 3.75, 0.3,
           sz=10, col=WHITE)
        y += 0.92

    box(s, 0, 6.82, 13.33, 0.68, fill=NAVY)
    tx(s, "Exports at /export/ feed PowerBI directly — nodes.csv and edges CSVs update with each data reload.",
       0.35, 6.9, 12.6, 0.42, sz=12, bold=True,
       col=WHITE, align=PP_ALIGN.CENTER, italic=True)


# ── SLIDE 4 · The Pivot ───────────────────────────────────────────────────────
def s4_pivot(prs):
    s = blank(prs)
    hdr(s, "4", "The Pivot — Methodology First",
        "Why we changed direction from the previous iteration")

    # Left: Team K
    box(s, 0.28, 1.15, 6.1, 0.42, fill=GREY)
    tx(s, "Team K  (Previous Iteration — NetworkMap)", 0.38, 1.18, 5.9, 0.38,
       sz=13, bold=True, col=WHITE)
    buls(s, [
        "Built a visual tool for Dan to explore connections himself",
        "6 typed relationship categories defined in the UI",
        "Flask + React + MongoDB — interactive, user-driven",
        "Sector taxonomy: 6 buckets, manually assigned",
        "Strength: low barrier to entry for a non-technical user",
        "Gap: no documented pipeline, no reproducible export,\n"
        "      analysis lived inside the interface",
    ], 0.35, 1.65, 5.85, 4.0, sz=12, sub=GREY)

    # Divider
    box(s, 6.58, 1.1, 0.05, 5.9, fill=LIGHT)

    # Right: Our approach
    box(s, 6.75, 1.15, 6.28, 0.42, fill=BLUE)
    tx(s, "Our Approach — Pipeline + Reproducibility", 6.85, 1.18, 6.1, 0.38,
       sz=13, bold=True, col=WHITE)
    buls(s, [
        "Methodology at the forefront — every step is documented",
        "SNA normalization: 73 raw variants → 11 canonical sectors in code",
        "Django + SQLite — git clone → make setup → make run",
        "Three graph models (bipartite, co-attendance, 3-layer directed)",
        "CSV exports compatible with Kumu.io, Gephi, and PowerBI",
        "Future classes and solo development can extend the pipeline\n"
        "      without reverse-engineering what was built",
    ], 6.82, 1.65, 6.1, 4.0, sz=12, sub=GREY)

    # Bottom: the why
    box(s, 0, 5.38, 13.33, 0.05, fill=LIGHT)
    box(s, 0, 5.45, 13.33, 1.35, fill=LTBLUE)
    tx(s, "Why this matters to Dan Bassill:", 0.35, 5.52, 5.0, 0.36,
       sz=13, bold=True, col=NAVY)
    tx(s, "The Tutor/Mentor Connection's value is its network and its documented approach to building community. "
       "A reproducible pipeline mirrors that philosophy — it's not just what the data shows, it's that anyone "
       "can verify how we got there and extend it. That's the methodology Dan wants at the forefront.",
       0.35, 5.9, 12.6, 0.78, sz=12, col=NAVY, wrap=True)

    box(s, 0, 6.82, 13.33, 0.68, fill=NAVY)
    tx(s, "Deliberate scope: substantial work intentionally left for Summer 2026 solo development "
       "and future E583/E483 classes.",
       0.35, 6.9, 12.6, 0.42, sz=12, bold=True,
       col=WHITE, align=PP_ALIGN.CENTER, italic=True)


# ── SLIDE 5 · Pipeline Reproducibility ────────────────────────────────
def s5_insights(prs):
    s = blank(prs)
    hdr(s, "5", "Why the Data Pipeline Is the Deliverable",
        "What makes this process replicable for any conference dataset")

    insights = [
        (BLUE,   LTBLUE,
         "Normalization is Step Zero: the hardest step",
         "Any real conference dataset will have messy category data. Mapping 73 raw SNA variants to 11 canonical "
         "sectors in code means the next team inherits a verified, auditable starting point rather than a manual "
         "guessing game. This step is what makes cross-conference comparison possible."),
        (GREEN,  LTGRN,
         "The graph models work on any org-event attendance dataset",
         "The bipartite, co-attendance, and three-layer graphs are built from two columns: organization and event. "
         "Any organization running attendance-tracked conferences can load their spreadsheet into the same pipeline "
         "and get the same structural analysis out the other side."),
        (ORANGE, LTOR,
         "Exports connect to tools stakeholders already use",
         "nodes.csv and edges CSVs are formatted for Kumu.io, Gephi, and PowerBI directly. The analysis does not "
         "live inside the platform; it lives in files any stakeholder can open, share, or import into whatever "
         "tool they already know."),
        (PURPLE, LTPUR,
         "One-command setup is the handoff mechanism",
         "git clone + make setup + make run is how this project passes to the next team. The pipeline is not "
         "documented separately from the code; the Makefile and load_data command are the documentation. "
         "A new team can be running in minutes, not weeks."),
        (GREY,   LIGHT,
         "Documented data quality is institutional memory",
         "Knowing 4.2% of records have blank org names, knowing what the 73 raw variants were, means future teams "
         "inherit a clear picture of the data's limitations rather than re-discovering them. Every quality "
         "decision is in code or in writing."),
    ]

    y = 1.18
    for color, bg, title, desc in insights:
        box(s, 0.28, y, 12.77, 1.09, fill=bg)
        box(s, 0.28, y, 0.22, 1.09, fill=color)
        tx(s, title, 0.65, y+0.06, 12.0, 0.38, sz=12, bold=True, col=color)
        tx(s, desc,  0.65, y+0.5,  12.2, 0.52, sz=11, col=NAVY, wrap=True)
        y += 1.16


# ── SLIDE 6 · Next Steps ─────────────────────────────────────────────────────
def s6_next(prs):
    s = blank(prs)
    hdr(s, "6", "What's Next",
        "Remaining work before April 26 final checkpoint")

    cols = [
        (0.28,  BLUE,   "Platform  (by Apr 26)",
         ["Kumu.io step-by-step import guide",
          "Surface org website URLs in search results",
          "Final reproducibility audit",
          "Incorporate peer + instructor feedback"]),
        (4.58,  GREEN,  "Data Cleaning  (by Apr 26)",
         ["Trim whitespace — 323 org entries",
          "Flag/fill 272 blank org records",
          "Website URLs for top 20–30 orgs",
          "Reload pipeline with updated XLSX"]),
        (8.88,  ORANGE, "Writing & Presentation",
         ["Refine PowerBI charts after today's feedback",
          "2–3 actionable insights for final report",
          "Final report — 4 pages, research format",
          "Final presentation: Apr 28, Fine Arts 102"]),
    ]
    for x, color, title, pts in cols:
        box(s, x, 1.15, 4.05, 0.48, fill=color)
        tx(s, title, x+0.1, 1.17, 3.9, 0.44,
           sz=14, bold=True, col=WHITE, align=PP_ALIGN.CENTER)
        buls(s, pts, x+0.1, 1.72, 3.85, 2.7, sz=13)

    box(s, 0, 4.6, 13.33, 0.05, fill=LIGHT)

    tx(s, "Peer Feedback  (individual — due April 12, 8pm EST)",
       0.28, 4.72, 6.5, 0.38, sz=13, bold=True)
    tx(s, "Review 2 other teams across all 5 rubric points. Submit as PDF — not on discussion board.",
       0.28, 5.1, 12.8, 0.36, sz=12, col=NAVY)

    box(s, 0, 5.6, 13.33, 0.05, fill=LIGHT)
    tx(s, "Intentionally deferred to Summer 2026 & future classes:",
       0.28, 5.72, 7.0, 0.36, sz=13, bold=True, col=ORANGE)
    tx(s, "Kumu live API  ·  Interactive D3 network  ·  SNA centrality metrics  "
       "·  Admin data upload  ·  Fuzzy org deduplication  ·  Multi-dataset support",
       0.28, 6.1, 12.8, 0.36, sz=12, col=GREY)

    box(s, 0, 6.75, 13.33, 0.75, fill=NAVY)
    tx(s, "Roadmap is live at /roadmap/  —  scope decisions are documented, not hidden.",
       0.35, 6.85, 12.6, 0.42, sz=13, bold=True,
       col=WHITE, align=PP_ALIGN.CENTER, italic=True)


def build():
    prs = new_prs()
    s1_title(prs)
    s2_stakeholder(prs)
    s3_dashboard(prs)
    s4_pivot(prs)
    s5_insights(prs)
    s6_next(prs)
    out = "Intermediate_Presentation.pptx"
    prs.save(out)
    print(f"Saved: {out}  ({len(prs.slides)} slides)")


if __name__ == "__main__":
    build()
