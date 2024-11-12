from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import login_user, register_user, TransactionViewSet, AccountViewSet, BudgetGoalViewSet, SavingsGoalViewSet

# Setting up the router for the viewsets
router = DefaultRouter()
router.register(r'transactions', TransactionViewSet)
router.register(r'accounts', AccountViewSet)
router.register(r'budget-goals', BudgetGoalViewSet)
router.register(r'savings-goals', SavingsGoalViewSet)

# Define the urlpatterns correctly
urlpatterns = [
    # Include the routes from the router
    path('api/', include(router.urls)),
    
    # Register and login endpoints
    path('api/register/', register_user, name='register_user'),
    path('api/login/', login_user, name='login_user'),
]
