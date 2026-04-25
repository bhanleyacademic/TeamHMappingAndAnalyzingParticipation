"""
Generate three network maps mirroring Team K's Kumu visualizations:
  1. Organization–Event bipartite network
  2. Organization–Organization co-attendance network (sector-colored)
  3. Event→Sector→Organization three-layer network

Output: network_maps/ directory with PNG files.
Run with: .venv/bin/python generate_network_maps.py
"""

import os
import django

os.environ.setdefault("DJANGO_SETTINGS_MODULE",
                      "MappingAndAnalyzingParticipation.settings")
django.setup()

from collections import defaultdict

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import networkx as nx

from conferences.models import Attendance

OUT_DIR = "network_maps"
os.makedirs(OUT_DIR, exist_ok=True)

# ---------------------------------------------------------------------------
# Sector color palette (matching dashboard)
# ---------------------------------------------------------------------------
SECTOR_COLORS = {
    "Program":      "#2196F3",
    "Resource":     "#4CAF50",
    "College":      "#9C27B0",
    "Intermediary": "#FF9800",
    "Business":     "#F44336",
    "T/MC":         "#009688",
    "Government":   "#607D8B",
    "K-12 School":  "#E91E63",
    "Faith":        "#795548",
    "Foundation":   "#FFC107",
    "Other":        "#9E9E9E",
}
EVENT_COLOR  = "#FF6B35"   # orange — conference events
ORG_COLOR    = "#1A3A5C"   # navy — org default


# ---------------------------------------------------------------------------
# Load data
# ---------------------------------------------------------------------------
print("Loading data...")
records = list(
    Attendance.objects.exclude(organization="")
    .values("organization", "sna_category", "conference", "year", "month")
)
print(f"  {len(records)} records loaded")

# Build lookup: org -> primary sector (most common)
org_sector_counts = defaultdict(lambda: defaultdict(int))
for r in records:
    org_sector_counts[r["organization"]][r["sna_category"]] += 1

org_sector = {
    org: max(sectors, key=sectors.get)
    for org, sectors in org_sector_counts.items()
}

# Org -> set of conferences attended
org_events = defaultdict(set)
for r in records:
    org_events[r["organization"]].add(r["conference"])

# Conference -> set of orgs
event_orgs = defaultdict(set)
for r in records:
    event_orgs[r["conference"]].add(r["organization"])

# Org -> event count (years of participation)
org_event_count = {org: len(evts) for org, evts in org_events.items()}


# ---------------------------------------------------------------------------
# Helper: draw and save
# ---------------------------------------------------------------------------
def save(fig, name, dpi=180):
    path = os.path.join(OUT_DIR, name)
    fig.savefig(path, dpi=dpi, bbox_inches="tight",
                facecolor=fig.get_facecolor())
    print(f"  Saved: {path}")
    plt.close(fig)


def legend_patches(color_map, title="Sector"):
    return [
        mpatches.Patch(color=c, label=lbl)
        for lbl, c in color_map.items()
    ]


# ---------------------------------------------------------------------------
# MAP 1 — Organization–Event Bipartite Network
# Mirrors Team K Fig 8: teal orgs, orange events, edge = attendance
# Node size encodes years of participation (org) or total attendees (event)
# Limit to orgs with >= 3 events and events with >= 15 orgs for readability
# ---------------------------------------------------------------------------
print("\nBuilding Map 1: Org–Event Bipartite...")

MIN_ORG_EVENTS  = 3   # orgs must have attended this many conferences
MIN_EVT_ORGS    = 10  # events must have had this many orgs

active_orgs = {o for o, ec in org_event_count.items() if ec >= MIN_ORG_EVENTS}
active_events = {e for e, os_ in event_orgs.items() if len(os_) >= MIN_EVT_ORGS}

B = nx.Graph()
for org in active_orgs:
    B.add_node(f"ORG:{org}", kind="org",
               sector=org_sector.get(org, "Other"),
               weight=org_event_count[org])

for evt in active_events:
    B.add_node(f"EVT:{evt}", kind="event", weight=len(event_orgs[evt]))

for r in records:
    org, evt = r["organization"], r["conference"]
    if org in active_orgs and evt in active_events:
        B.add_edge(f"ORG:{org}", f"EVT:{evt}")

print(f"  Nodes: {B.number_of_nodes()} | Edges: {B.number_of_edges()}")

org_nodes  = [n for n, d in B.nodes(data=True) if d["kind"] == "org"]
evt_nodes  = [n for n, d in B.nodes(data=True) if d["kind"] == "event"]

pos = nx.spring_layout(B, seed=42, k=1.2)

org_colors = [SECTOR_COLORS.get(B.nodes[n]["sector"], "#9E9E9E") for n in org_nodes]
org_sizes  = [max(80, B.nodes[n]["weight"] * 30) for n in org_nodes]
evt_sizes  = [max(200, B.nodes[n]["weight"] * 8) for n in evt_nodes]

fig, ax = plt.subplots(figsize=(16, 12), facecolor="#0D1B2A")
ax.set_facecolor("#0D1B2A")
ax.axis("off")

nx.draw_networkx_edges(B, pos, ax=ax, alpha=0.15, width=0.5,
                       edge_color="#AAAAAA")
nx.draw_networkx_nodes(B, pos, nodelist=evt_nodes, ax=ax,
                       node_color=EVENT_COLOR, node_size=evt_sizes,
                       alpha=0.9)
nx.draw_networkx_nodes(B, pos, nodelist=org_nodes, ax=ax,
                       node_color=org_colors, node_size=org_sizes,
                       alpha=0.85)

# Label events only
evt_labels = {n: n.replace("EVT:", "") for n in evt_nodes}
nx.draw_networkx_labels(B, pos, labels=evt_labels, ax=ax,
                        font_size=7, font_color="white", font_weight="bold")

# Legend
sector_legend = legend_patches(SECTOR_COLORS)
sector_legend.append(mpatches.Patch(color=EVENT_COLOR, label="Conference Event"))
ax.legend(handles=sector_legend, loc="lower left", fontsize=8,
          facecolor="#1A3A5C", edgecolor="none", labelcolor="white",
          title="Node Type / Sector", title_fontsize=9)

ax.set_title(
    "Organization–Event Bipartite Network\n"
    "Node size = years participated (org) or attendees (event)  ·  "
    f"Orgs ≥{MIN_ORG_EVENTS} events shown  ·  "
    f"{B.number_of_nodes()} nodes, {B.number_of_edges()} edges",
    color="white", fontsize=13, pad=12
)
save(fig, "map1_org_event_bipartite.png")


# ---------------------------------------------------------------------------
# MAP 2 — Organization–Organization Co-attendance Network
# Mirrors Team K's org-org view.
# Edge weight = number of shared conferences.
# Only show top orgs (by event count) for readability.
# ---------------------------------------------------------------------------
print("\nBuilding Map 2: Org–Org Co-attendance...")

TOP_N = 120        # top orgs by events attended
MIN_WEIGHT = 3     # minimum shared conferences to draw an edge

top_orgs = sorted(active_orgs, key=lambda o: org_event_count[o], reverse=True)[:TOP_N]
top_org_set = set(top_orgs)

# Build co-attendance weights
pair_weight = defaultdict(int)
for evt, orgs in event_orgs.items():
    shared = [o for o in orgs if o in top_org_set]
    shared_sorted = sorted(shared)
    for i, a in enumerate(shared_sorted):
        for b in shared_sorted[i + 1:]:
            pair_weight[(a, b)] += 1

G2 = nx.Graph()
for org in top_orgs:
    G2.add_node(org, sector=org_sector.get(org, "Other"),
                events=org_event_count[org])

for (a, b), w in pair_weight.items():
    if w >= MIN_WEIGHT:
        G2.add_edge(a, b, weight=w)

# Remove isolates
G2.remove_nodes_from(list(nx.isolates(G2)))
print(f"  Nodes: {G2.number_of_nodes()} | Edges: {G2.number_of_edges()}")

pos2 = nx.spring_layout(G2, seed=7, k=0.9,
                         weight="weight", iterations=80)

node_colors = [SECTOR_COLORS.get(G2.nodes[n]["sector"], "#9E9E9E")
               for n in G2.nodes()]
node_sizes  = [max(60, G2.nodes[n]["events"] * 25) for n in G2.nodes()]
edge_weights= [G2[u][v]["weight"] for u, v in G2.edges()]
max_w = max(edge_weights) if edge_weights else 1
edge_alphas = [0.15 + 0.55 * (w / max_w) for w in edge_weights]
edge_widths = [0.3 + 2.5 * (w / max_w) for w in edge_weights]

fig, ax = plt.subplots(figsize=(16, 12), facecolor="#0D1B2A")
ax.set_facecolor("#0D1B2A")
ax.axis("off")

# Draw edges with varying alpha
for (u, v), alpha, width in zip(G2.edges(), edge_alphas, edge_widths):
    nx.draw_networkx_edges(G2, pos2, edgelist=[(u, v)], ax=ax,
                           alpha=alpha, width=width, edge_color="#CCCCCC")

nx.draw_networkx_nodes(G2, pos2, ax=ax, node_color=node_colors,
                       node_size=node_sizes, alpha=0.9)

# Label only high-degree nodes
degree_dict = dict(G2.degree())
top_degree = sorted(degree_dict, key=degree_dict.get, reverse=True)[:20]
labels2 = {n: n[:22] for n in top_degree}
nx.draw_networkx_labels(G2, pos2, labels=labels2, ax=ax,
                        font_size=6.5, font_color="white")

ax.legend(handles=legend_patches(SECTOR_COLORS),
          loc="lower left", fontsize=8,
          facecolor="#1A3A5C", edgecolor="none", labelcolor="white",
          title="Sector", title_fontsize=9)
ax.set_title(
    "Organization–Organization Co-attendance Network\n"
    f"Top {G2.number_of_nodes()} orgs  ·  Edge weight = shared conferences (≥{MIN_WEIGHT})  ·  "
    f"{G2.number_of_edges()} edges  ·  Node size = events attended",
    color="white", fontsize=13, pad=12
)
save(fig, "map2_org_org_coattendance.png")


# ---------------------------------------------------------------------------
# MAP 3 — Event→Sector→Organization Three-layer Network
# Mirrors Team K Fig 11.
# Limit to a focused time window for legibility (2004–2010 peak years).
# ---------------------------------------------------------------------------
print("\nBuilding Map 3: Three-layer Event→Sector→Org...")

YEAR_MIN, YEAR_MAX = 2004, 2010
MIN_ORG_EVT_3 = 4   # org must attend >= this many events in window

filtered = [r for r in records
            if r["year"] and YEAR_MIN <= int(r["year"]) <= YEAR_MAX
            and r["organization"] in active_orgs]

# Org event counts within window
org_ec_window = defaultdict(set)
for r in filtered:
    org_ec_window[r["organization"]].add(r["conference"])
window_orgs = {o for o, es in org_ec_window.items() if len(es) >= MIN_ORG_EVT_3}

# Events in window
window_events = {r["conference"] for r in filtered}

G3 = nx.DiGraph()

# Event nodes
for evt in window_events:
    G3.add_node(evt, kind="event", layer=0)

# Sector nodes
sectors_in_window = {r["sna_category"] for r in filtered if r["organization"] in window_orgs}
for sec in sectors_in_window:
    G3.add_node(sec, kind="sector", layer=1)

# Org nodes
for org in window_orgs:
    G3.add_node(org, kind="org", layer=2)

# Event→Sector edges
evt_sec_pairs = set()
for r in filtered:
    if r["organization"] in window_orgs:
        evt_sec_pairs.add((r["conference"], r["sna_category"]))
for (evt, sec) in evt_sec_pairs:
    G3.add_edge(evt, sec)

# Sector→Org edges
sec_org_pairs = set()
for r in filtered:
    if r["organization"] in window_orgs:
        sec_org_pairs.add((r["sna_category"], r["organization"]))
for (sec, org) in sec_org_pairs:
    G3.add_edge(sec, org)

print(f"  Nodes: {G3.number_of_nodes()} | Edges: {G3.number_of_edges()}")

# Layered layout: left=events, center=sectors, right=orgs
def layered_pos(G, layer_attr="layer"):
    layers = defaultdict(list)
    for n, d in G.nodes(data=True):
        layers[d.get(layer_attr, 0)].append(n)

    pos = {}
    x_positions = {0: 0.0, 1: 1.0, 2: 2.0}
    for layer_idx, nodes in layers.items():
        x = x_positions[layer_idx]
        n = len(nodes)
        for i, node in enumerate(sorted(nodes)):
            y = (i - n / 2) / max(n, 1) * 10
            pos[node] = (x, y)
    return pos

pos3 = layered_pos(G3)

evt_nodes3  = [n for n, d in G3.nodes(data=True) if d["kind"] == "event"]
sec_nodes3  = [n for n, d in G3.nodes(data=True) if d["kind"] == "sector"]
org_nodes3  = [n for n, d in G3.nodes(data=True) if d["kind"] == "org"]

fig, ax = plt.subplots(figsize=(18, 13), facecolor="#0D1B2A")
ax.set_facecolor("#0D1B2A")
ax.axis("off")

nx.draw_networkx_edges(G3, pos3, ax=ax, alpha=0.2, width=0.6,
                       edge_color="#AAAAAA", arrows=False)

nx.draw_networkx_nodes(G3, pos3, nodelist=evt_nodes3, ax=ax,
                       node_color=EVENT_COLOR, node_size=180, alpha=0.9)
nx.draw_networkx_nodes(G3, pos3, nodelist=sec_nodes3, ax=ax,
                       node_color=[SECTOR_COLORS.get(s, "#9E9E9E") for s in sec_nodes3],
                       node_size=600, alpha=0.95)
nx.draw_networkx_nodes(G3, pos3, nodelist=org_nodes3, ax=ax,
                       node_color=[SECTOR_COLORS.get(
                           org_sector.get(n, "Other"), "#9E9E9E") for n in org_nodes3],
                       node_size=80, alpha=0.8)

# Labels: events (short), sectors (full), top orgs only
evt_labels3  = {n: n for n in evt_nodes3}
sec_labels3  = {n: n for n in sec_nodes3}
top_org3 = sorted(org_nodes3,
                   key=lambda o: len(org_ec_window.get(o, [])),
                   reverse=True)[:25]
org_labels3  = {n: n[:18] for n in top_org3}

nx.draw_networkx_labels(G3, pos3, labels=evt_labels3,  ax=ax,
                        font_size=6,   font_color="white")
nx.draw_networkx_labels(G3, pos3, labels=sec_labels3,  ax=ax,
                        font_size=9,   font_color="white", font_weight="bold")
nx.draw_networkx_labels(G3, pos3, labels=org_labels3,  ax=ax,
                        font_size=5.5, font_color="#CCCCCC")

# Layer annotations
for lbl, x in [("Conference Events", 0.0), ("Sectors", 1.0), ("Organizations", 2.0)]:
    ax.text(x, ax.get_ylim()[1] if ax.get_ylim()[1] != 1.0 else 6.5,
            lbl, color="#F5A623", fontsize=11, fontweight="bold",
            ha="center", transform=ax.transData)

ax.legend(handles=legend_patches(SECTOR_COLORS) + [
              mpatches.Patch(color=EVENT_COLOR, label="Conference Event")],
          loc="lower left", fontsize=8,
          facecolor="#1A3A5C", edgecolor="none", labelcolor="white",
          title="Sector", title_fontsize=9)
ax.set_title(
    f"Event → Sector → Organization  (Three-Layer Network, {YEAR_MIN}–{YEAR_MAX} peak years)\n"
    f"Orgs attending ≥{MIN_ORG_EVT_3} events in window shown  ·  "
    f"{G3.number_of_nodes()} nodes, {G3.number_of_edges()} edges",
    color="white", fontsize=13, pad=12
)
save(fig, "map3_event_sector_org_threelayer.png")

print(f"\nAll maps saved to ./{OUT_DIR}/")
print("  map1_org_event_bipartite.png")
print("  map2_org_org_coattendance.png")
print("  map3_event_sector_org_threelayer.png")
