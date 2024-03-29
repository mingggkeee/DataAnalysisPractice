from django.contrib import admin
from django.urls import path, include

from .views import HomeView, MarketInfoView, SearchView, StocksDetailView

urlpatterns = [
    path('', HomeView.as_view(), name="home"),
    path('market/', MarketInfoView.as_view(), name='market'),
    path('search/<str:key>', SearchView.as_view(), name='search'),
    path('<str:pk>', StocksDetailView.as_view(), name='detail'),
    path('<str:pk>/stats', StocksDetailView.as_view(), name="detail_stats"),
]
