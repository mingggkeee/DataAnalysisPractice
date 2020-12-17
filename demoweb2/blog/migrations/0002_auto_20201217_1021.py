# Generated by Django 3.1.4 on 2020-12-17 01:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0001_initial'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='post',
            options={'ordering': ('-modify_dt',), 'verbose_name': 'post', 'verbose_name_plural': 'posts'},
        ),
        migrations.AlterField(
            model_name='post',
            name='slug',
            field=models.SlugField(allow_unicode=True, help_text='one word for title alias. ', max_length=100, verbose_name='SLUG'),
        ),
        migrations.AlterModelTable(
            name='post',
            table='blog_posts',
        ),
    ]