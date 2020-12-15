from django.urls import path, include

from . import views

urlpatterns = [

    # Example : polls/
    # path('', views.Index, name="index"), # 함수형 뷰
    path('', views.IndexView.as_view(), name="index"), # 클래스형 뷰

    # Example : polls/1 or polls/2 or polls/3 or .... polls/{n}
    # path('<int:question_id>/', views.detail, name ='detail'), # <자료형:변수이름>
    path('<int:pk>/', views.QuestionDetailView.as_view(), name ='detail'), # <자료형:변수이름>

    # Example : polls/1/vote or polls/2/vote or polls/3/vote ...
    path('<int:question_id>/vote/', views.vote, name ='vote'),
    
    # Example : polls/1/results or polls/2/results or polls/3/results ...
    path('<int:pk>/results/', views.VoteResultView.as_view(), name ='results')
]