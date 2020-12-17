from django.views.generic.base import TemplateView

# class형 뷰를 만들때는 상속을 받아야합니다

# def home(request):
#     render(request, 'home.html', None)

class HomeView(TemplateView):
    template_name = 'home.html'