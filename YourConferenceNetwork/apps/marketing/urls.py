from django.urls import path
from . import views

app_name = 'marketing'

urlpatterns = [
    path('', views.HomeView.as_view(), name='home'),
    path('pricing/', views.PricingView.as_view(), name='pricing'),
    path('how-it-works/', views.HowItWorksView.as_view(), name='how_it_works'),
    path('about/', views.AboutView.as_view(), name='about'),
    path('faq/', views.FaqView.as_view(), name='faq'),
    path('contact/', views.contact, name='contact'),
    path('waitlist/', views.waitlist_signup, name='waitlist'),
]
