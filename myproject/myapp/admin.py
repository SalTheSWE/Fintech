import django
from django.contrib import admin

models = django.apps.apps.get_models()

for model in models:
    # Skip models from the 'auth' app to avoid duplicate registrations
    if model._meta.app_label == "auth":
        continue
    try:
        admin.site.register(model)
    except admin.sites.AlreadyRegistered:
        pass