from django import views
from django.urls import path
from .views import onboarding, register, home

urlpatterns = [
    path('register/', register, name='register'),
    path('', home, name='home'),
    path('onboarding/', onboarding, name='onboarding'),
]