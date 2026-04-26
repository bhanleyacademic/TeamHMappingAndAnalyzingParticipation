from django.urls import path
from . import views

urlpatterns = [
    path('plans/', views.plan_list, name='billing-plans'),
    path('subscription/', views.subscription_detail, name='billing-subscription'),
    path('checkout/', views.checkout, name='billing-checkout'),
    path('portal/', views.portal, name='billing-portal'),
    path('webhook/', views.stripe_webhook, name='billing-webhook'),
]
