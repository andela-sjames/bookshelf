from __future__ import unicode_literals

from django.db import models

# Create your models here.
class Category(models.Model):
    name = models.CharField(max_length=60)

    def __unicode__(self):
        return self.name

class Book(models.Model):
    title = models.CharField(max_length=60)
    author = models.CharField(max_length=60)
    category = models.ForeignKey(
        Category,
        on_delete=models.CASCADE, 
        related_name='books')

    def __unicode__(self):
        return self.title