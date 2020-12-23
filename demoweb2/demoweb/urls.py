"""demoweb URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.http.response import HttpResponse
from django.conf.urls.static import static
from django.conf import settings
from demoweb.views import HomeView, UserCreateView, UserCreateDoneView

urlpatterns = [
    path('', HomeView.as_view(), name='home'),
    path('admin/', admin.site.urls),

    path('accounts/', include('django.contrib.auth.urls')),  # accounts/login
    path('accounts/register/', UserCreateView.as_view(), name='register'),  
    path('accounts/register/done/', UserCreateDoneView.as_view(), name='register_done'),  

    # path('bookmark/', None, name="bookmark-index")
    path('bookmark/', include('bookmark.urls')),    # bookmark로 시작되는 url 설정 관리는 bookmark/urls.py 에서 처리합니다.
    path('blog/', include('blog.urls')),            # blog로 시작되는 url 설정 관리는 blog/urls.py 에서 처리합니다.
    path('photo/', include('photo.urls')),          # photo로 시작되는 url 설정 관리는 photo/urls.py 에서 처리합니다.
    
] + static(settings.MEDIA_URL, document_root = settings.MEDIA_ROOT) # 이 요청과 경로에 대해서 static 처리하는 설정 -> View를 거치지 않고 직접 다운로드하는 방식으로 처리
