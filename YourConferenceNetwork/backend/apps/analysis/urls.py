from django.urls import path
from . import views

urlpatterns = [
    path('datasets/', views.dataset_list_create, name='dataset-list'),
    path('datasets/<int:pk>/', views.dataset_detail, name='dataset-detail'),
    path('datasets/<int:pk>/status/', views.dataset_status, name='dataset-status'),
    # Analysis endpoints — populated in Phase 2
    path('datasets/<int:pk>/dashboard/', views.dataset_dashboard, name='dataset-dashboard'),
    path('datasets/<int:pk>/chart/', views.dataset_chart, name='dataset-chart'),
    path('datasets/<int:pk>/data-quality/', views.dataset_data_quality, name='dataset-data-quality'),
    path('datasets/<int:pk>/search/', views.dataset_search, name='dataset-search'),
    # Gated: network maps (paid)
    path('datasets/<int:pk>/networks/org-event/', views.network_org_event, name='network-org-event'),
    path('datasets/<int:pk>/networks/org-org/', views.network_org_org, name='network-org-org'),
    path('datasets/<int:pk>/networks/three-layer/', views.network_three_layer, name='network-three-layer'),
    # Gated: CSV exports (paid)
    path('datasets/<int:pk>/exports/nodes/', views.export_nodes, name='export-nodes'),
    path('datasets/<int:pk>/exports/edges/org-event/', views.export_edges_org_event, name='export-edges-org-event'),
    path('datasets/<int:pk>/exports/edges/org-org/', views.export_edges_org_org, name='export-edges-org-org'),
    path('datasets/<int:pk>/exports/edges/event-sector-org/', views.export_edges_event_sector_org, name='export-edges-event-sector-org'),
    # Template download (public — no auth required to download blank template)
    path('datasets/template/', views.download_template, name='dataset-template'),
    # Public Kumu remote-source endpoints — authenticated by per-dataset UUID token, open CORS
    path('kumu/<uuid:token>/org-event/', views.kumu_public_org_event, name='kumu-public-org-event'),
    path('kumu/<uuid:token>/org-org/', views.kumu_public_org_org, name='kumu-public-org-org'),
    path('kumu/<uuid:token>/three-layer/', views.kumu_public_three_layer, name='kumu-public-three-layer'),
]
