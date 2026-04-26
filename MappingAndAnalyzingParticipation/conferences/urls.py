from django.urls import path
from . import views

app_name = "conferences"

urlpatterns = [
    path("", views.index, name="index"),
    path("methodology/", views.methodology, name="methodology"),
    path("search/", views.participant_search, name="participant_search"),
    path("previous-iteration/", views.previous_iteration, name="previous_iteration"),
    path("dashboard/", views.dashboard, name="dashboard"),
    path("chart/", views.participation_chart, name="chart"),
    path("data-quality/", views.data_quality, name="data_quality"),
    # Network maps
    path("network-maps/", views.network_maps, name="network_maps"),
    path("network-maps/org-event.png", views.map_org_event, name="map_org_event"),
    path("network-maps/org-org.png", views.map_org_org, name="map_org_org"),
    path("network-maps/three-layer.png", views.map_three_layer, name="map_three_layer"),
    # Kumu.io live blueprints (one per graph type, mirrors CSV exports)
    path("api/kumu/org-event.json", views.kumu_org_event, name="kumu_org_event"),
    path("api/kumu/org-org.json", views.kumu_org_org, name="kumu_org_org"),
    path("api/kumu/3layer.json", views.kumu_3layer, name="kumu_3layer"),
    # Export endpoints
    path("export/nodes/", views.export_nodes, name="export_nodes"),
    path("export/edges/org-event/", views.export_edges_org_event, name="export_edges_org_event"),
    path("export/edges/org-org/", views.export_edges_org_org, name="export_edges_org_org"),
    path("export/edges/event-sector-org/", views.export_edges_event_sector_org, name="export_edges_event_sector_org"),
]
