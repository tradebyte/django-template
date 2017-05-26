from {{ project_name }}.settings.base import *

# Database
# https://docs.djangoproject.com/en/1.11/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': '{{ project_name }}',
        'USER': 'postgres',
        'PASSWORD': 'mypassword',
        'HOST': 'postgres',
        'PORT': '5432'
    }
}