"""
Generate the Project Plan presentation as a .pptx file.
Run with: .venv/bin/python build_slides.py
"""

from pptx import Presentation
from pptx.util import Inches, Pt, Emu
from pptx.dml.color import RGBColor
from pptx.enum.text import PP_ALIGN
from pptx.util import Inches, Pt

# Brand colors
NAVY   = RGBColor(0x1A, 0x3A, 0x5C)   # dark blue
GOLD   = RGBColor(0xF5, 0xA6, 0x23)   # IU-ish amber
WHITE  = RGBColor(0xFF, 0xFF, 0xFF)
LIGHT  = RGBColor(0xF0, 0xF4, 0xF8)
GRAY   = RGBColor(0x55, 0x55, 0x55)
GREEN  = RGBColor(0x2E, 0x7D, 0x32)

prs = Presentation()
prs.slide_width  = Inches(13.33)
prs.slide_height = Inches(7.5)

BLANK = prs.slide_layouts[6]   # completely blank


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def add_rect(slide, left, top, width, height, fill_rgb=None, line_rgb=None):
    shape = slide.shapes.add_shape(
        1,  # MSO_SHAPE_TYPE.RECTANGLE
        Inches(left), Inches(top), Inches(width), Inches(height)
    )
    if fill_rgb:
        shape.fill.solid()
        shape.fill.fore_color.rgb = fill_rgb
    else:
        shape.fill.background()
    if line_rgb:
        shape.line.color.rgb = line_rgb
        shape.line.width = Pt(1)
    else:
        shape.line.fill.background()
    return shape


def add_text(slide, text, left, top, width, height,
             font_size=18, bold=False, color=None, align=PP_ALIGN.LEFT,
             italic=False, wrap=True):
    txBox = slide.shapes.add_textbox(
        Inches(left), Inches(top), Inches(width), Inches(height)
    )
    tf = txBox.text_frame
    tf.word_wrap = wrap
    p = tf.paragraphs[0]
    p.alignment = align
    run = p.add_run()
    run.text = text
    run.font.size = Pt(font_size)
    run.font.bold = bold
    run.font.italic = italic
    run.font.color.rgb = color or NAVY
    return txBox


def add_bullet_box(slide, items, left, top, width, height,
                   font_size=16, title=None, title_size=17,
                   color=None, bullet="▸ "):
    txBox = slide.shapes.add_textbox(
        Inches(left), Inches(top), Inches(width), Inches(height)
    )
    tf = txBox.text_frame
    tf.word_wrap = True

    first = True
    if title:
        p = tf.paragraphs[0]
        p.alignment = PP_ALIGN.LEFT
        run = p.add_run()
        run.text = title
        run.font.size = Pt(title_size)
        run.font.bold = True
        run.font.color.rgb = NAVY
        first = False

    for item in items:
        if first:
            p = tf.paragraphs[0]
            first = False
        else:
            p = tf.add_paragraph()
        p.alignment = PP_ALIGN.LEFT
        run = p.add_run()
        run.text = f"{bullet}{item}"
        run.font.size = Pt(font_size)
        run.font.color.rgb = color or GRAY
    return txBox


def navy_header(slide, title, subtitle=None):
    """Full-width navy header bar at top."""
    add_rect(slide, 0, 0, 13.33, 1.2, fill_rgb=NAVY)
    add_text(slide, title, 0.4, 0.1, 12.5, 0.7,
             font_size=28, bold=True, color=WHITE, align=PP_ALIGN.LEFT)
    if subtitle:
        add_text(slide, subtitle, 0.4, 0.8, 12.5, 0.4,
                 font_size=14, color=GOLD, align=PP_ALIGN.LEFT)
    # gold accent bar
    add_rect(slide, 0, 1.2, 13.33, 0.06, fill_rgb=GOLD)


def footer(slide, text="Mapping & Analyzing Participation  |  IU Luddy  |  Spring 2026"):
    add_rect(slide, 0, 7.15, 13.33, 0.35, fill_rgb=NAVY)
    add_text(slide, text, 0.3, 7.18, 12.7, 0.3,
             font_size=10, color=LIGHT, align=PP_ALIGN.LEFT)


# ---------------------------------------------------------------------------
# Slide 1 — Title slide
# ---------------------------------------------------------------------------

slide = prs.slides.add_slide(BLANK)

# Full navy background top half
add_rect(slide, 0, 0, 13.33, 4.5, fill_rgb=NAVY)
add_rect(slide, 0, 4.5, 13.33, 3.0, fill_rgb=LIGHT)

# Gold accent
add_rect(slide, 0, 4.5, 13.33, 0.08, fill_rgb=GOLD)

# Title
add_text(slide,
         "Mapping & Analyzing Participation",
         0.6, 0.7, 12.0, 1.0,
         font_size=36, bold=True, color=WHITE, align=PP_ALIGN.CENTER)
add_text(slide,
         "in Tutor/Mentor Leadership and Networking Conferences",
         0.6, 1.65, 12.0, 0.8,
         font_size=24, bold=False, color=GOLD, align=PP_ALIGN.CENTER)

# Divider
add_rect(slide, 2.5, 2.7, 8.33, 0.05, fill_rgb=WHITE)

# Team
add_text(slide,
         "Brian Hanley  ·  Matthew Ramsey  ·  Timothy Okoye  ·  Patrick Sullivan",
         0.6, 2.85, 12.0, 0.5,
         font_size=16, color=WHITE, align=PP_ALIGN.CENTER)
add_text(slide,
         "Indiana University  |  Luddy School of Informatics, Computing, and Engineering",
         0.6, 3.35, 12.0, 0.4,
         font_size=13, italic=True, color=LIGHT, align=PP_ALIGN.CENTER)

# Lower half
add_text(slide, "Client:", 1.5, 4.9, 2.0, 0.4,
         font_size=14, bold=True, color=GRAY)
add_text(slide, "Daniel F. Bassill  |  Tutor/Mentor Institute, LLC",
         3.0, 4.9, 9.0, 0.4,
         font_size=14, color=NAVY)

add_text(slide, "Course:", 1.5, 5.4, 2.0, 0.4,
         font_size=14, bold=True, color=GRAY)
add_text(slide, "E483/E583 Information Visualization  |  Spring 2026",
         3.0, 5.4, 9.0, 0.4,
         font_size=14, color=NAVY)

add_text(slide, "Submission:", 1.5, 5.9, 2.0, 0.4,
         font_size=14, bold=True, color=GRAY)
add_text(slide, "Presentation of Project Plans  —  March 22, 2026",
         3.0, 5.9, 9.0, 0.4,
         font_size=14, color=NAVY)


# ---------------------------------------------------------------------------
# Slide 2 — Stakeholders & Their Needs
# ---------------------------------------------------------------------------

slide = prs.slides.add_slide(BLANK)
navy_header(slide, "Stakeholders & Their Needs",
            "Who uses this tool, and what do they need from it?")
footer(slide)
add_rect(slide, 0, 1.26, 13.33, 5.89, fill_rgb=LIGHT)

# Four stakeholder cards
cards = [
    ("Daniel F. Bassill / T/MC",
     ["Track who attends and their role in mentorship",
      "Communicate network history to funders & partners",
      "Color-coded, searchable Kumu.io map with org hyperlinks"]),
    ("Nonprofits & Organizations",
     ["Understand which sectors engage in the network",
      "Identify peer organizations to contact",
      "Learn from & replicate Bassill's methodology"]),
    ("Conference Participants",
     ["See their own place in the network",
      "Discover who else attended the same events",
      "Explore connections within their sector"]),
    ("Researchers & Civic Advocates",
     ["Clean, documented, reproducible dataset",
      "Consistent labels for structural SNA analysis",
      "Open-source pipeline for future research teams"]),
]

card_w = 2.9
card_gap = 0.25
card_left_start = 0.4

for i, (title, bullets) in enumerate(cards):
    cl = card_left_start + i * (card_w + card_gap)
    add_rect(slide, cl, 1.45, card_w, 4.9, fill_rgb=WHITE)
    add_rect(slide, cl, 1.45, card_w, 0.45, fill_rgb=NAVY)
    add_text(slide, title, cl + 0.1, 1.52, card_w - 0.2, 0.38,
             font_size=13, bold=True, color=WHITE)
    add_bullet_box(slide, bullets,
                   cl + 0.12, 2.05, card_w - 0.2, 4.1,
                   font_size=13, color=GRAY, bullet="• ")


# ---------------------------------------------------------------------------
# Slide 3 — Research Questions
# ---------------------------------------------------------------------------

slide = prs.slides.add_slide(BLANK)
navy_header(slide, "Research Questions",
            "Drafted by Matthew Guschwan — guiding our analysis and visualization design")
footer(slide)
add_rect(slide, 0, 1.26, 13.33, 5.89, fill_rgb=LIGHT)

questions = [
    ("1",
     "Network Navigability",
     "How can the network be organized to be useful to someone who does not know any specific participants — what sectoral or structural entry points make it navigable?"),
    ("2",
     "Temporal Progression",
     "Can we show how the network formed and expanded between 1994 and 2015 — revealing which sectors grew, which stayed consistent, and where gaps appeared?"),
    ("3",
     "Supernodes & Bridge Actors",
     "Are there highly active or influential organizations beyond Bassill himself? How do they function as connectors between sectors and as bridges to under-represented groups?"),
    ("4",
     "Geographic & Outreach Gaps",
     "Are there geographic or organizational gaps in participation that could inform targeted outreach to Chicago high-poverty neighborhoods?"),
]

for i, (num, label, desc) in enumerate(questions):
    row = i // 2
    col = i % 2
    ql = 0.4 + col * 6.55
    qt = 1.55 + row * 2.65
    add_rect(slide, ql, qt, 6.2, 2.4, fill_rgb=WHITE)
    # number circle background
    add_rect(slide, ql + 0.1, qt + 0.12, 0.55, 0.55, fill_rgb=NAVY)
    add_text(slide, num, ql + 0.1, qt + 0.12, 0.55, 0.55,
             font_size=18, bold=True, color=WHITE, align=PP_ALIGN.CENTER)
    add_text(slide, label, ql + 0.75, qt + 0.12, 5.3, 0.45,
             font_size=14, bold=True, color=NAVY)
    add_text(slide, desc, ql + 0.12, qt + 0.75, 5.9, 1.55,
             font_size=13, color=GRAY)


# ---------------------------------------------------------------------------
# Slide 4 — Dataset Statistics
# ---------------------------------------------------------------------------

slide = prs.slides.add_slide(BLANK)
navy_header(slide, "Dataset Statistics",
            "Source: TeamK-cleaned CSV (updated Feb 11, 2026) — 42 conferences, May 1994 – Nov 2014")
footer(slide)
add_rect(slide, 0, 1.26, 13.33, 5.89, fill_rgb=LIGHT)

# Big metric boxes
metrics = [
    ("6,410",  "Attendance Records"),
    ("41",     "Conference Events"),
    ("2,163",  "Unique Organizations"),
    ("20 yrs", "Data Coverage"),
]
mx_w = 2.6
mx_gap = 0.35
mx_start = 0.5
for i, (val, lbl) in enumerate(metrics):
    ml = mx_start + i * (mx_w + mx_gap)
    add_rect(slide, ml, 1.5, mx_w, 1.5, fill_rgb=NAVY)
    add_text(slide, val, ml, 1.6, mx_w, 0.75,
             font_size=30, bold=True, color=WHITE, align=PP_ALIGN.CENTER)
    add_text(slide, lbl, ml, 2.3, mx_w, 0.55,
             font_size=13, color=GOLD, align=PP_ALIGN.CENTER)

# SNA table
add_text(slide, "SNA Category Distribution (after normalization)",
         0.5, 3.25, 8.0, 0.4,
         font_size=14, bold=True, color=NAVY)

rows = [
    ("Program",      "3,310", "51.6%"),
    ("Resource",       "612",  "9.5%"),
    ("College/Univ",   "559",  "8.7%"),
    ("K-12 School",    "418",  "6.5%"),
    ("Other",          "572",  "8.9%"),
    ("T/MC",           "239",  "3.7%"),
    ("Intermediary",   "227",  "3.5%"),
    ("Faith",          "148",  "2.3%"),
    ("Government",     "136",  "2.1%"),
    ("Business",       "131",  "2.0%"),
    ("Foundation",      "58",  "0.9%"),
]
col_x = [0.5, 4.5, 6.2]
# header
for cx, hdr in zip(col_x, ["Category", "Records", "% of Total"]):
    add_rect(slide, cx, 3.7, 1.8 if cx == 0.5 else 1.5, 0.32, fill_rgb=NAVY)
    add_text(slide, hdr, cx + 0.05, 3.73, 1.7, 0.28,
             font_size=11, bold=True, color=WHITE)

for r, (cat, cnt, pct) in enumerate(rows):
    ty = 4.04 + r * 0.27
    bg = LIGHT if r % 2 == 0 else WHITE
    for cx, val, cw in zip(col_x, [cat, cnt, pct], [1.8, 1.5, 1.5]):
        add_rect(slide, cx, ty, cw, 0.27, fill_rgb=bg)
        add_text(slide, val, cx + 0.05, ty + 0.02, cw - 0.1, 0.24,
                 font_size=11, color=GRAY)

# Right side note
add_text(slide,
         "18 fields per record\n\n"
         "Geographically concentrated\nin Chicago metro area\n\n"
         "~70 raw SNA variants\nnormalized to 11\ncanonical categories\n\n"
         "Significant blank fields\nin Title & Org Name\n(esp. pre-2000)",
         8.0, 3.25, 4.9, 4.0,
         font_size=13, color=GRAY)


# ---------------------------------------------------------------------------
# Slide 5 — Visualization Method 1: Frequency Chart
# ---------------------------------------------------------------------------

slide = prs.slides.add_slide(BLANK)
navy_header(slide, "Visualization 1: Participation Frequency Chart",
            "Interactive Plotly stacked bar — attendance per event, segmented by organization type")
footer(slide)
add_rect(slide, 0, 1.26, 13.33, 5.89, fill_rgb=LIGHT)

# Placeholder for screenshot
add_rect(slide, 0.4, 1.5, 8.4, 5.3, fill_rgb=WHITE)
add_rect(slide, 0.4, 1.5, 8.4, 5.3, line_rgb=NAVY)
add_text(slide,
         "[INSERT SCREENSHOT]\nhttp://127.0.0.1:8000/chart/",
         0.4, 3.3, 8.4, 1.2,
         font_size=14, color=GRAY, align=PP_ALIGN.CENTER, italic=True)

# Callouts
add_bullet_box(slide,
    ["Built with Plotly — fully interactive (hover, zoom, filter)",
     "Stacked bars show contribution of each sector per event",
     "Filterable by year, sector, and state via dashboard",
     "Reveals peak attendance years (mid-2000s)",
     "Program sector dominant across all 20 years",
     "College & Resource sectors grew steadily over time",
     "Gaps visible in early (pre-1998) and late (post-2012) years"],
    9.0, 1.55, 4.1, 5.2,
    font_size=13, color=GRAY,
    title="Key Insights", title_size=14)


# ---------------------------------------------------------------------------
# Slide 6 — Visualization Method 2: Network Export (Kumu.io)
# ---------------------------------------------------------------------------

slide = prs.slides.add_slide(BLANK)
navy_header(slide, "Visualization 2: Network Export for Kumu.io / Gephi",
            "Django pipeline generates Nodes + Edges CSVs on-demand in 4 graph modes")
footer(slide)
add_rect(slide, 0, 1.26, 13.33, 5.89, fill_rgb=LIGHT)

# Network placeholder
add_rect(slide, 0.4, 1.5, 7.5, 5.3, fill_rgb=WHITE)
add_rect(slide, 0.4, 1.5, 7.5, 5.3, line_rgb=NAVY)
add_text(slide,
         "[INSERT KUMU NETWORK SCREENSHOT\nor Team K reference map]",
         0.4, 3.5, 7.5, 1.0,
         font_size=14, color=GRAY, align=PP_ALIGN.CENTER, italic=True)

# Four modes
modes = [
    ("Org ↔ Event",        "Bipartite: each attendance = one edge"),
    ("Org ↔ Org",          "Co-attendance edges, weighted by shared events"),
    ("Event→Sector→Org",   "Three-layer cross-sector network"),
    ("Nodes Only",         "Organizations with sector, event count, record count"),
]
add_text(slide, "Export Modes", 8.1, 1.55, 5.0, 0.4,
         font_size=14, bold=True, color=NAVY)
for i, (mode, desc) in enumerate(modes):
    mt = 2.05 + i * 1.0
    add_rect(slide, 8.1, mt, 5.0, 0.85, fill_rgb=WHITE)
    add_rect(slide, 8.1, mt, 0.08, 0.85, fill_rgb=GOLD)
    add_text(slide, mode, 8.28, mt + 0.04, 4.7, 0.35,
             font_size=13, bold=True, color=NAVY)
    add_text(slide, desc, 8.28, mt + 0.44, 4.7, 0.35,
             font_size=12, color=GRAY)

add_text(slide,
         "Color-coded by SNA category  ·  Search by participant  ·  Org hyperlinks (planned)",
         8.1, 6.1, 5.0, 0.4,
         font_size=11, italic=True, color=GRAY)


# ---------------------------------------------------------------------------
# Slide 7 — Key Insights & Next Steps
# ---------------------------------------------------------------------------

slide = prs.slides.add_slide(BLANK)
navy_header(slide, "Key Insights & Next Steps",
            "What we've learned from the initial analysis, and where we go from here")
footer(slide)
add_rect(slide, 0, 1.26, 13.33, 5.89, fill_rgb=LIGHT)

# Insights
add_rect(slide, 0.4, 1.5, 6.0, 5.65, fill_rgb=WHITE)
add_rect(slide, 0.4, 1.5, 6.0, 0.4, fill_rgb=NAVY)
add_text(slide, "Initial Insights", 0.55, 1.55, 5.8, 0.32,
         font_size=14, bold=True, color=WHITE)
add_bullet_box(slide,
    ["Program-sector orgs = 52% of all participation — the consistent core of the network",
     "2,163 unique organizations attended — broad but Chicago-concentrated",
     "Co-attendance edges reveal candidate 'supernodes' that bridge sectors",
     "Peak attendance: mid-2000s; visible drops post-2012",
     "~70 raw SNA variants successfully normalized to 11 canonical categories",
     "Data quality gaps concentrated in pre-2000 Title & Organization fields"],
    0.52, 2.05, 5.75, 4.8,
    font_size=13, color=GRAY)

# Next steps
add_rect(slide, 6.9, 1.5, 6.0, 5.65, fill_rgb=WHITE)
add_rect(slide, 6.9, 1.5, 6.0, 0.4, fill_rgb=GREEN)
add_text(slide, "Next Steps", 7.05, 1.55, 5.8, 0.32,
         font_size=14, bold=True, color=WHITE)
add_bullet_box(slide,
    ["URL enrichment: cross-reference orgs against tutormentorexchange.net directory",
     "Identify & label supernodes in the org↔org co-attendance network",
     "Complete Kumu.io map with color-coding, search, and embedded hyperlinks",
     "Sector-based graph modes (Event→Sector→Org) fully functional",
     "Analytics dashboard: degree distribution, top-entity tables, data quality flags",
     "Meeting with Daniel Bassill to review results and gather feedback",
     "GitHub repository + Docker image published for future teams"],
    7.05, 2.05, 5.75, 4.8,
    font_size=13, color=GRAY)


# ---------------------------------------------------------------------------
# Save
# ---------------------------------------------------------------------------

out = "MappingAndAnalyzingParticipation_ProjectPlan.pptx"
prs.save(out)
print(f"Saved: {out}")
