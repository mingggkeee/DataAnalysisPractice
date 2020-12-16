from django.db import models

# Create your models here.

class Bookmark(models.Model):
    title = models.CharField(max_length=100, blank=True) # varchar(100)
    url = models.URLField(unique=True) # 중복되면 안되니까 unique 특성 주기

    def __str__(self):
        return self.title