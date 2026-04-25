from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('', include('apps.marketing.urls')),
    path('app/', include('apps.core.urls')),
    path('admin/', admin.site.urls),
]
