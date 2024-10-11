from django.shortcuts import render

# Create your views here.
from django.shortcuts import render, redirect
from django.contrib.auth import login
from .forms import RegistrationForm

def register(request):
    if request.method == 'POST':
        form = RegistrationForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)  # Log the user in after registration
            return redirect('home')  # Redirect to a success page
    else:
        form = RegistrationForm()
    return render(request, 'registration/register.html', {'form': form})

def home(request):
    return render(request, 'home.html') 

def onboarding(request):
    return render(request, 'onboarding.html')