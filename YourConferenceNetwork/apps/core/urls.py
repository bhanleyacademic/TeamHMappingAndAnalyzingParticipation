from django.urls import path
from . import views

app_name = "core"

urlpatterns = [
    path("", views.index, name="index"),
    path("dashboard/", views.dashboard, name="dashboard"),
    path("chart/", views.participation_chart, name="chart"),
    path("data-quality/", views.data_quality, name="data_quality"),
    # Network maps
    path("network-maps/", views.network_maps, name="network_maps"),
    path("network-maps/org-event.png", views.map_org_event, name="map_org_event"),
    path("network-maps/org-org.png", views.map_org_org, name="map_org_org"),
    path("network-maps/three-layer.png", views.map_three_layer, name="map_three_layer"),
    # Export endpoints
    path("export/nodes/", views.export_nodes, name="export_nodes"),
    path("export/edges/org-event/", views.export_edges_org_event, name="export_edges_org_event"),
    path("export/edges/org-org/", views.export_edges_org_org, name="export_edges_org_org"),
    path("export/edges/event-sector-org/", views.export_edges_event_sector_org, name="export_edges_event_sector_org"),
]
