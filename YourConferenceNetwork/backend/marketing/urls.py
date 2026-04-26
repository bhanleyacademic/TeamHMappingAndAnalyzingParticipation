from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('about/', views.about, name='about'),
    path('services/', views.services, name='services'),
    path('pricing/', views.pricing, name='pricing'),
    path('contact/', views.contact, name='contact'),
    path('faq/', views.faq, name='faq'),
    # Vue SPA shell — catches all /app/* paths
    path('app/', views.spa_shell, name='spa-shell'),
    path('app/<path:path>/', views.spa_shell, name='spa-shell-path'),
]
