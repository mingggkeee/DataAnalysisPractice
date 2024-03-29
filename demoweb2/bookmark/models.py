from django.db import models

from django.contrib.auth.models import User

# Create your models here.

class Bookmark(models.Model):
    title = models.CharField(max_length=100, blank=True) # varchar(100)
    url = models.URLField(unique=True) # 중복되면 안되니까 unique 특성 주기
    owner = models.ForeignKey(User, on_delete=models.CASCADE, blank=True, null=True, verbose_name="OWNER")

    def __str__(self):
        return self.title