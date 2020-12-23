from django.urls import path
from photo.views import AlbumLV, AlbumDV, PhotoDV, AlbumPhotoCV, AlbumChangeLV, AlbumPhotoUV, AlbumDelV, PhotoCV, PhotoChangeLV, PhotoUV, PhotoDelV

from django.views.generic import DetailView, ListView
from photo.models import Album, Photo 

app_name='photo'
urlpatterns = [
    # Example: /photo/
    path('', ListView.as_view(model=Album), name='index'),

    # Example: /photo/album/, same as /photo/
    path('album', ListView.as_view(model=Album), name='album_list'),

    # Example: /photo/album/99/
    path('album/<int:pk>/', DetailView.as_view(model=Album), name='album_detail'),

    # Example: /photo/photo/99/
    path('photo/<int:pk>/', DetailView.as_view(model=Photo), name='photo_detail'),

    # Example: /photo/album/add/
    path('album/add/', AlbumPhotoCV.as_view(), name="album_add",),

    # Example: /photo/album/change/
    path('album/change/', AlbumChangeLV.as_view(), name="album_change",),

    # Example: /photo/album/99/update/
    path('album/<int:pk>/update/', AlbumPhotoUV.as_view(), name="album_update",),

    # Example: /photo/album/99/delete/
    path('album/<int:pk>/delete/', AlbumDelV.as_view(), name="album_delete",),

    # Example: /photo/photo/add/
    path('photo/add/', PhotoCV.as_view(), name="photo_add",),

    # Example: /photo/photo/change/
    path('photo/change/', PhotoChangeLV.as_view(), name="photo_change",),

    # Example: /photo/photo/99/update/
    path('photo/<int:pk>/update/', PhotoUV.as_view(), name="photo_update",),

    # Example: /photo/photo/99/delete/
    path('photo/<int:pk>/delete/', PhotoDelV.as_view(), name="photo_delete",),
]