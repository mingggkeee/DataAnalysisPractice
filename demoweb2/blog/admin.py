from django.contrib import admin

from blog.models import Post

# Register your models here.

@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    """
    Post 모델이 관리자 application에서 어떻게 다루어지는지 설정하는 클래스
    """

    list_display = ['id', 'title', 'modify_dt', 'tag_list']
    list_filter = ['modify_dt']
    search_fields = ['title', 'content']
    prepopulated_fields = {'slug' : ('title',)}

    def get_queryset(self, request):
        return super().get_queryset(request).prefetch_related('tags')

    def tag_list(self, obj):
        return ', '.join(o.name for o in obj.tags.all())


# admin.site.register(Post, PostAdmin)