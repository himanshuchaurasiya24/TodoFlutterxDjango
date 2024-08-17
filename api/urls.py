# from django.contrib import admin
from django.urls import include, path
from .views import *
urlpatterns = [
    path('', TodoGet.as_view()),
    path('<int:pk>', TodoUpdateDelete.as_view())
]
