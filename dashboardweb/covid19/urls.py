from django.contrib import admin
from django.urls import path, include

from .views import HomeView, ConfirmedStatView

urlpatterns = [
    path('', HomeView.as_view(), name='home'),
    path('confirmed/', ConfirmedStatView.as_view(), name='confirmed')
]