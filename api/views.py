from django.shortcuts import render
from rest_framework import generics
from .models import *
from .serializers import TodoSerializer
# Create your views here.
class TodoGet(generics.ListCreateAPIView):
    queryset= Todo.objects.all()
    serializer_class = TodoSerializer
class TodoUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset= Todo.objects.all()
    serializer_class = TodoSerializer
def update_todo(id):
    queryset = Todo.objects.get(id = id)
    queryset.title='updated'
    queryset.save()
    print(queryset)

