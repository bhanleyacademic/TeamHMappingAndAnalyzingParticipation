import csv
import io
import json
from collections import defaultdict

import matplotlib
matplotlib.use("Agg")
import matplotlib.patches as mpatches
import matplotlib.pyplot as plt
import networkx as nx
import plotly.graph_objects as go
from django.db.models import Count, Q
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render

from .models import Attendance
from .sna_normalize import CANONICAL_CATEGORIES


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def _base_qs(request):
    """Return Attendance queryset filtered by GET params (year, sector, state)."""
    qs = Attendance.objects.all()
    year = request.GET.get("year")
    sector = request.GET.get("sector")
    state = request.GET.get("state")
    if year:
        qs = qs.filter(year=year)
    if sector and sector in CANONICAL_CATEGORIES:
        qs = qs.filter(sna_category=sector)
    if state:
        qs = qs.filter(state__iexact=state)
    return qs


def _available_years():
    return (
        Attendance.objects.exclude(year__isnull=True)
        .values_list("year", flat=True)
        .distinct()
        .order_by("year")
    )


def _available_states():
    return (
        Attendance.objects.exclude(state="")
        .values_list("state", flat=True)
        .distinct()
        .order_by("state")
    )


# ---------------------------------------------------------------------------
# Landing page
# ---------------------------------------------------------------------------

def index(request):
    total = Attendance.objects.count()
    return render(request, "conferences/index.html", {"total": total})


# ---------------------------------------------------------------------------
# Analytics dashboard
# ---------------------------------------------------------------------------

def dashboard(request):
    qs = _base_qs(request)

    # --- network overview metrics ---
    total_records = qs.count()
    unique_orgs = qs.exclude(organization="").values("organization").distinct().count()
    unique_events = qs.values("conference").distinct().count()

    # average connections per org (events attended)
    org_event_counts = (
        qs.exclude(organization="")
        .values("organization")
        .annotate(events=Count("conference", distinct=True))
    )
    avg_connections = (
        sum(o["events"] for o in org_event_counts) / len(org_event_counts)
        if org_event_counts
        else 0
    )

    # --- data quality ---
    missing_org = qs.filter(Q(organization="") | Q(organization__isnull=True)).count()
    missing_sna = qs.filter(Q(sna_category="") | Q(sna_category__isnull=True)).count()

    # --- top organizations by attendance ---
    top_orgs = (
        qs.exclude(organization="")
        .values("organization", "sna_category")
        .annotate(count=Count("id"))
        .order_by("-count")[:15]
    )

    # --- top conferences by attendance ---
    top_events = (
        qs.values("conference", "year", "month")
        .annotate(count=Count("id"))
        .order_by("-count")[:10]
    )

    # --- sector distribution ---
    sector_counts = (
        qs.values("sna_category")
        .annotate(count=Count("id"))
        .order_by("-count")
    )

    # --- participation frequency chart (Plotly) ---
    chart_html = _participation_chart(request)

    context = {
        "total_records": total_records,
        "unique_orgs": unique_orgs,
        "unique_events": unique_events,
        "avg_connections": round(avg_connections, 2),
        "missing_org": missing_org,
        "missing_sna": missing_sna,
        "top_orgs": top_orgs,
        "top_events": top_events,
        "sector_counts": sector_counts,
        "chart_html": chart_html,
        # filter state
        "years": list(_available_years()),
        "sectors": CANONICAL_CATEGORIES,
        "states": list(_available_states()),
        "selected_year": request.GET.get("year", ""),
        "selected_sector": request.GET.get("sector", ""),
        "selected_state": request.GET.get("state", ""),
    }
    return render(request, "conferences/dashboard.html", context)


# ---------------------------------------------------------------------------
# Participation frequency chart
# ---------------------------------------------------------------------------

def _participation_chart(request):
    """Return an embedded Plotly HTML div for attendance per event by sector."""
    qs = _base_qs(request)

    # Group by (year, month, conference) × sna_category
    rows = (
        qs.values("year", "month", "conference", "sna_category")
        .annotate(count=Count("id"))
        .order_by("year", "month")
    )

    # Build series: sector -> list of (conference_label, count)
    series = defaultdict(lambda: defaultdict(int))
    conferences_ordered = []
    seen = set()
    for row in rows:
        label = row["conference"]
        if label not in seen:
            seen.add(label)
            conferences_ordered.append(label)
        series[row["sna_category"]][label] += row["count"]

    # Sort conferences chronologically
    conferences_ordered = sorted(
        conferences_ordered,
        key=lambda c: (
            int(c.split("/")[1]) if "/" in c else 0,
            int(c.split("/")[0]) if "/" in c else 0,
        ),
    )

    sector_colors = {
        "Program": "#2196F3",
        "Resource": "#4CAF50",
        "College": "#9C27B0",
        "Intermediary": "#FF9800",
        "Business": "#F44336",
        "T/MC": "#009688",
        "Government": "#607D8B",
        "K-12 School": "#E91E63",
        "Faith": "#795548",
        "Foundation": "#FFC107",
        "Other": "#9E9E9E",
    }

    fig = go.Figure()
    for sector in CANONICAL_CATEGORIES:
        counts = [series[sector].get(c, 0) for c in conferences_ordered]
        if any(counts):
            fig.add_trace(
                go.Bar(
                    name=sector,
                    x=conferences_ordered,
                    y=counts,
                    marker_color=sector_colors.get(sector, "#9E9E9E"),
                )
            )

    fig.update_layout(
        barmode="stack",
        title="Attendance per Conference Event by Organization Type",
        xaxis_title="Conference (MM/YYYY)",
        yaxis_title="Number of Attendees",
        legend_title="Sector",
        height=450,
        margin=dict(l=40, r=20, t=50, b=120),
        xaxis=dict(tickangle=-45),
        plot_bgcolor="white",
        paper_bgcolor="white",
    )

    return fig.to_html(full_html=False, include_plotlyjs="cdn")


def participation_chart(request):
    """Standalone chart view."""
    chart_html = _participation_chart(request)
    return render(
        request,
        "conferences/chart.html",
        {
            "chart_html": chart_html,
            "years": list(_available_years()),
            "sectors": CANONICAL_CATEGORIES,
            "states": list(_available_states()),
            "selected_year": request.GET.get("year", ""),
            "selected_sector": request.GET.get("sector", ""),
            "selected_state": request.GET.get("state", ""),
        },
    )


# ---------------------------------------------------------------------------
# Export views
# ---------------------------------------------------------------------------

def _response_csv(filename: str) -> HttpResponse:
    response = HttpResponse(content_type="text/csv")
    response["Content-Disposition"] = f'attachment; filename="{filename}"'
    return response


def export_nodes(request):
    """
    Export organizations as Kumu/Gephi nodes CSV.
    Columns: Id, Label, SNA_Category, Event_Count, Years_Active
    """
    qs = _base_qs(request)
    orgs = (
        qs.exclude(organization="")
        .values("organization", "sna_category")
        .annotate(
            event_count=Count("conference", distinct=True),
            record_count=Count("id"),
        )
        .order_by("organization")
    )

    response = _response_csv("nodes.csv")
    writer = csv.writer(response)
    writer.writerow(["Id", "Label", "SNA_Category", "Event_Count", "Record_Count"])
    for org in orgs:
        writer.writerow([
            org["organization"],
            org["organization"],
            org["sna_category"],
            org["event_count"],
            org["record_count"],
        ])
    return response


def export_edges_org_event(request):
    """
    Organization ↔ Event bipartite edges (Kumu from/to).
    Also includes conference event nodes.
    """
    qs = _base_qs(request)
    attendances = qs.exclude(organization="").values(
        "organization", "conference", "sna_category", "year", "month"
    )

    response = _response_csv("edges_org_event.csv")
    writer = csv.writer(response)
    writer.writerow(["From", "To", "Type", "Year", "Month"])
    for a in attendances:
        writer.writerow([
            a["organization"],
            a["conference"],
            a["sna_category"],
            a["year"],
            a["month"],
        ])
    return response


def export_edges_org_org(request):
    """
    Organization ↔ Organization edges based on co-attendance at same conference.
    Edge weight = number of shared conferences.
    """
    qs = _base_qs(request)

    # Build: conference -> list of orgs
    conf_orgs = defaultdict(set)
    for a in qs.exclude(organization="").values("conference", "organization"):
        conf_orgs[a["conference"]].add(a["organization"])

    # Count shared conferences between org pairs
    pair_weight = defaultdict(int)
    for orgs in conf_orgs.values():
        orgs_list = sorted(orgs)
        for i, a in enumerate(orgs_list):
            for b in orgs_list[i + 1:]:
                pair_weight[(a, b)] += 1

    response = _response_csv("edges_org_org.csv")
    writer = csv.writer(response)
    writer.writerow(["Source", "Target", "Weight", "Type"])
    for (src, tgt), weight in sorted(pair_weight.items(), key=lambda x: -x[1]):
        writer.writerow([src, tgt, weight, "Undirected"])
    return response


def export_edges_event_sector_org(request):
    """
    Three-layer export: Event → Sector → Organization (clean attendance-only).
    Produces two edge files combined: event-sector edges + sector-org edges.
    """
    qs = _base_qs(request)
    attendances = qs.exclude(organization="").values(
        "organization", "conference", "sna_category"
    )

    # event-sector pairs and sector-org pairs
    event_sector = set()
    sector_org = set()
    for a in attendances:
        event_sector.add((a["conference"], a["sna_category"]))
        sector_org.add((a["sna_category"], a["organization"]))

    response = _response_csv("edges_event_sector_org.csv")
    writer = csv.writer(response)
    writer.writerow(["From", "To", "Layer"])
    for evt, sec in sorted(event_sector):
        writer.writerow([evt, sec, "Event-Sector"])
    for sec, org in sorted(sector_org):
        writer.writerow([sec, org, "Sector-Org"])
    return response


# ---------------------------------------------------------------------------
# Data quality / validation view
# ---------------------------------------------------------------------------

def data_quality(request):
    total = Attendance.objects.count()
    missing_org = Attendance.objects.filter(
        Q(organization="") | Q(organization__isnull=True)
    ).count()
    missing_sna = Attendance.objects.filter(
        Q(sna_category="") | Q(sna_category__isnull=True)
    ).count()
    unmapped = Attendance.objects.filter(sna_category="Other").count()

    # Distribution of original vs normalized categories
    original_dist = (
        Attendance.objects.values("sna_category_original")
        .annotate(count=Count("id"))
        .order_by("-count")[:30]
    )
    normalized_dist = (
        Attendance.objects.values("sna_category")
        .annotate(count=Count("id"))
        .order_by("-count")
    )

    context = {
        "total": total,
        "missing_org": missing_org,
        "missing_sna": missing_sna,
        "unmapped": unmapped,
        "original_dist": original_dist,
        "normalized_dist": normalized_dist,
    }
    return render(request, "conferences/data_quality.html", context)


# ---------------------------------------------------------------------------
# Network map views
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
EVENT_COLOR = "#FF6B35"
BG_COLOR    = "#0D1B2A"


def _build_org_lookups():
    """Shared data for all three network maps."""
    records = list(
        Attendance.objects.exclude(organization="")
        .values("organization", "sna_category", "conference", "year")
    )
    org_sector_counts = defaultdict(lambda: defaultdict(int))
    org_events = defaultdict(set)
    event_orgs = defaultdict(set)
    for r in records:
        org_sector_counts[r["organization"]][r["sna_category"]] += 1
        org_events[r["organization"]].add(r["conference"])
        event_orgs[r["conference"]].add(r["organization"])

    org_sector = {
        org: max(secs, key=secs.get)
        for org, secs in org_sector_counts.items()
    }
    org_event_count = {org: len(evts) for org, evts in org_events.items()}
    return records, org_sector, org_event_count, org_events, event_orgs


def _png_response(fig):
    buf = io.BytesIO()
    fig.savefig(buf, format="png", dpi=150, bbox_inches="tight",
                facecolor=fig.get_facecolor())
    plt.close(fig)
    buf.seek(0)
    return HttpResponse(buf.getvalue(), content_type="image/png")


def network_maps(request):
    """Landing page listing all three network maps."""
    return render(request, "conferences/network_maps.html")


def map_org_event(request):
    """Map 1 — Organization–Event bipartite network (PNG)."""
    records, org_sector, org_event_count, org_events, event_orgs = _build_org_lookups()

    active_orgs   = {o for o, ec in org_event_count.items() if ec >= 3}
    active_events = {e for e, os_ in event_orgs.items() if len(os_) >= 10}

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

    org_nodes = [n for n, d in B.nodes(data=True) if d["kind"] == "org"]
    evt_nodes = [n for n, d in B.nodes(data=True) if d["kind"] == "event"]
    pos = nx.spring_layout(B, seed=42, k=1.2)

    fig, ax = plt.subplots(figsize=(14, 10), facecolor=BG_COLOR)
    ax.set_facecolor(BG_COLOR)
    ax.axis("off")

    nx.draw_networkx_edges(B, pos, ax=ax, alpha=0.15, width=0.5, edge_color="#AAAAAA")
    nx.draw_networkx_nodes(B, pos, nodelist=evt_nodes, ax=ax,
                           node_color=EVENT_COLOR,
                           node_size=[max(200, B.nodes[n]["weight"] * 8) for n in evt_nodes],
                           alpha=0.9)
    nx.draw_networkx_nodes(B, pos, nodelist=org_nodes, ax=ax,
                           node_color=[SECTOR_COLORS.get(B.nodes[n]["sector"], "#9E9E9E") for n in org_nodes],
                           node_size=[max(80, B.nodes[n]["weight"] * 30) for n in org_nodes],
                           alpha=0.85)
    nx.draw_networkx_labels(B, pos,
                            labels={n: n.replace("EVT:", "") for n in evt_nodes},
                            ax=ax, font_size=7, font_color="white", font_weight="bold")

    patches = [mpatches.Patch(color=c, label=l) for l, c in SECTOR_COLORS.items()]
    patches.append(mpatches.Patch(color=EVENT_COLOR, label="Conference Event"))
    ax.legend(handles=patches, loc="lower left", fontsize=7,
              facecolor="#1A3A5C", edgecolor="none", labelcolor="white")
    ax.set_title("Organization–Event Bipartite Network\n"
                 f"{B.number_of_nodes()} nodes · {B.number_of_edges()} edges · "
                 "Node size = years participated (org) or attendees (event)",
                 color="white", fontsize=12, pad=10)
    return _png_response(fig)


def map_org_org(request):
    """Map 2 — Organization–Organization co-attendance network (PNG)."""
    records, org_sector, org_event_count, org_events, event_orgs = _build_org_lookups()

    active_orgs = {o for o, ec in org_event_count.items() if ec >= 3}
    top_orgs    = sorted(active_orgs, key=lambda o: org_event_count[o], reverse=True)[:120]
    top_org_set = set(top_orgs)

    pair_weight = defaultdict(int)
    for evt, orgs in event_orgs.items():
        shared = sorted(o for o in orgs if o in top_org_set)
        for i, a in enumerate(shared):
            for b in shared[i + 1:]:
                pair_weight[(a, b)] += 1

    G = nx.Graph()
    for org in top_orgs:
        G.add_node(org, sector=org_sector.get(org, "Other"), events=org_event_count[org])
    for (a, b), w in pair_weight.items():
        if w >= 3:
            G.add_edge(a, b, weight=w)
    G.remove_nodes_from(list(nx.isolates(G)))

    pos = nx.spring_layout(G, seed=7, k=0.9, weight="weight", iterations=80)
    edge_weights = [G[u][v]["weight"] for u, v in G.edges()]
    max_w = max(edge_weights) if edge_weights else 1

    fig, ax = plt.subplots(figsize=(14, 10), facecolor=BG_COLOR)
    ax.set_facecolor(BG_COLOR)
    ax.axis("off")

    for (u, v), w in zip(G.edges(), edge_weights):
        alpha = 0.15 + 0.55 * (w / max_w)
        width = 0.3 + 2.5 * (w / max_w)
        nx.draw_networkx_edges(G, pos, edgelist=[(u, v)], ax=ax,
                               alpha=alpha, width=width, edge_color="#CCCCCC")

    nx.draw_networkx_nodes(G, pos, ax=ax,
                           node_color=[SECTOR_COLORS.get(G.nodes[n]["sector"], "#9E9E9E") for n in G.nodes()],
                           node_size=[max(60, G.nodes[n]["events"] * 25) for n in G.nodes()],
                           alpha=0.9)

    top_degree = sorted(dict(G.degree()).items(), key=lambda x: x[1], reverse=True)[:20]
    nx.draw_networkx_labels(G, pos,
                            labels={n: n[:22] for n, _ in top_degree},
                            ax=ax, font_size=6.5, font_color="white")

    patches = [mpatches.Patch(color=c, label=l) for l, c in SECTOR_COLORS.items()]
    ax.legend(handles=patches, loc="lower left", fontsize=7,
              facecolor="#1A3A5C", edgecolor="none", labelcolor="white")
    ax.set_title("Organization–Organization Co-attendance Network\n"
                 f"{G.number_of_nodes()} orgs · {G.number_of_edges()} edges · "
                 "Edge weight = shared conferences · Node size = events attended",
                 color="white", fontsize=12, pad=10)
    return _png_response(fig)


def map_three_layer(request):
    """Map 3 — Event→Sector→Organization three-layer network (PNG)."""
    records, org_sector, org_event_count, org_events, event_orgs = _build_org_lookups()

    active_orgs = {o for o, ec in org_event_count.items() if ec >= 3}
    filtered = [r for r in records
                if r["year"] and 2004 <= int(r["year"]) <= 2010
                and r["organization"] in active_orgs]

    org_ec_window = defaultdict(set)
    for r in filtered:
        org_ec_window[r["organization"]].add(r["conference"])
    window_orgs   = {o for o, es in org_ec_window.items() if len(es) >= 4}
    window_events = {r["conference"] for r in filtered}
    sectors_seen  = {r["sna_category"] for r in filtered if r["organization"] in window_orgs}

    G = nx.DiGraph()
    for evt in window_events:
        G.add_node(evt, kind="event", layer=0)
    for sec in sectors_seen:
        G.add_node(sec, kind="sector", layer=1)
    for org in window_orgs:
        G.add_node(org, kind="org", layer=2)

    for r in filtered:
        if r["organization"] in window_orgs:
            G.add_edge(r["conference"], r["sna_category"])
            G.add_edge(r["sna_category"], r["organization"])

    # Layered positions
    layers = defaultdict(list)
    for n, d in G.nodes(data=True):
        layers[d["layer"]].append(n)
    pos = {}
    for layer_idx, nodes in layers.items():
        x = float(layer_idx)
        for i, node in enumerate(sorted(nodes)):
            pos[node] = (x, (i - len(nodes) / 2) / max(len(nodes), 1) * 10)

    evt_nodes = [n for n, d in G.nodes(data=True) if d["kind"] == "event"]
    sec_nodes = [n for n, d in G.nodes(data=True) if d["kind"] == "sector"]
    org_nodes = [n for n, d in G.nodes(data=True) if d["kind"] == "org"]

    fig, ax = plt.subplots(figsize=(16, 11), facecolor=BG_COLOR)
    ax.set_facecolor(BG_COLOR)
    ax.axis("off")

    nx.draw_networkx_edges(G, pos, ax=ax, alpha=0.2, width=0.6,
                           edge_color="#AAAAAA", arrows=False)
    nx.draw_networkx_nodes(G, pos, nodelist=evt_nodes, ax=ax,
                           node_color=EVENT_COLOR, node_size=200, alpha=0.9)
    nx.draw_networkx_nodes(G, pos, nodelist=sec_nodes, ax=ax,
                           node_color=[SECTOR_COLORS.get(s, "#9E9E9E") for s in sec_nodes],
                           node_size=700, alpha=0.95)
    nx.draw_networkx_nodes(G, pos, nodelist=org_nodes, ax=ax,
                           node_color=[SECTOR_COLORS.get(org_sector.get(n, "Other"), "#9E9E9E") for n in org_nodes],
                           node_size=90, alpha=0.8)
    nx.draw_networkx_labels(G, pos, labels={n: n for n in evt_nodes},
                            ax=ax, font_size=6, font_color="white")
    nx.draw_networkx_labels(G, pos, labels={n: n for n in sec_nodes},
                            ax=ax, font_size=9, font_color="white", font_weight="bold")
    top_orgs = sorted(org_nodes, key=lambda o: len(org_ec_window.get(o, [])), reverse=True)[:25]
    nx.draw_networkx_labels(G, pos, labels={n: n[:18] for n in top_orgs},
                            ax=ax, font_size=5.5, font_color="#CCCCCC")

    for lbl, xi in [("← Conference Events", 0.05), ("Sectors", 1.0), ("Organizations →", 1.95)]:
        y_top = max(p[1] for p in pos.values()) + 0.8
        ax.text(xi, y_top, lbl, color="#F5A623", fontsize=10,
                fontweight="bold", ha="center", transform=ax.transData)

    patches = [mpatches.Patch(color=c, label=l) for l, c in SECTOR_COLORS.items()]
    patches.append(mpatches.Patch(color=EVENT_COLOR, label="Conference Event"))
    ax.legend(handles=patches, loc="lower left", fontsize=7,
              facecolor="#1A3A5C", edgecolor="none", labelcolor="white")
    ax.set_title("Event → Sector → Organization  (2004–2010 Peak Years)\n"
                 f"{G.number_of_nodes()} nodes · {G.number_of_edges()} edges",
                 color="white", fontsize=12, pad=10)
    return _png_response(fig)
