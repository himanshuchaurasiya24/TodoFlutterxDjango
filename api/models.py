from django.db import models

# Create your models here.
class Todo(models.Model):
    title = models.CharField(max_length=50)
    desc = models.CharField(max_length=200)
    isDone = models.BooleanField(default=False)
    date = models.DateField(auto_now_add=True)
    def __str__(self) -> str:
        return f'{self.title} {self.desc[:20]}'
