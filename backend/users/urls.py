from django.db import router
from rest_framework import routers
from .api import UserViewSet
from django.urls import path


router = routers.SimpleRouter()
router.register('profile', UserViewSet)

urlpatterns = router.urls