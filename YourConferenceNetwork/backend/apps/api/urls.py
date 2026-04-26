from django.urls import path, include

urlpatterns = [
    path('auth/', include('apps.accounts.urls')),
    path('', include('apps.analysis.urls')),
    path('billing/', include('apps.billing.urls')),
    path('admin/', include('apps.api.admin_urls')),
]
