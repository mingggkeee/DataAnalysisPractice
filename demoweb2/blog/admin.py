from django.contrib import admin

from blog.models import Post

# Register your models here.

@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    """
    Post 모델이 관리자 application에서 어떻게 다루어지는지 설정하는 클래스
    """

    list_display = ['id', 'title', 'modify_dt']
    list_filter = ['modify_dt']
    search_fields = ['title', 'content']
    prepopulated_fields = {'slug' : ('title',)}


# admin.site.register(Post, PostAdmin)