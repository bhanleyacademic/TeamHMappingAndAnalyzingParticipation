from django.urls import path
from . import admin_views

urlpatterns = [
    path('users/', admin_views.user_list, name='admin-user-list'),
    path('users/<int:user_id>/', admin_views.user_detail, name='admin-user-detail'),
    path('users/<int:user_id>/impersonate/', admin_views.impersonate_start, name='admin-impersonate-start'),
    path('impersonate/stop/', admin_views.impersonate_stop, name='admin-impersonate-stop'),
    path('site-settings/', admin_views.site_settings, name='admin-site-settings'),
]
