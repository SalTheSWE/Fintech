from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import UserSettingsViewSet, login_user, register_user, TransactionViewSet, AccountViewSet, BudgetGoalViewSet, SavingsGoalViewSet
from .views import ChatSessionView, SendMessageView, ChatHistoryView, AIResponseView

from drf_yasg.views import get_schema_view
from drf_yasg import openapi
from rest_framework import permissions

schema_view = get_schema_view(
    openapi.Info(
        title="API Documentation",
        default_version='v1',
        description="API endpoints and usage",
    ),
    public=True,
    permission_classes=(permissions.AllowAny,),
)




# Setting up the router for the viewsets
router = DefaultRouter()
router.register(r'transactions', TransactionViewSet)
router.register(r'accounts', AccountViewSet)
router.register(r'budget-goals', BudgetGoalViewSet)
router.register(r'savings-goals', SavingsGoalViewSet)
router.register(r'usersettings', UserSettingsViewSet)

# Define the urlpatterns correctly
urlpatterns = [
    # Include the routes from the router
    path('api/', include(router.urls)),
    # chat endpoints
    path('api/chat/session/', ChatSessionView.as_view(), name='chat-session'),
    path('api/chat/session/<int:session_id>/message/', SendMessageView.as_view(), name='send-message'),
    path('api/chat/session/<int:session_id>/history/', ChatHistoryView.as_view(), name='chat-history'),
    path('api/chat/session/<int:session_id>/ai-response/', AIResponseView.as_view(), name='ai-response'),

    
    # Register and login endpoints
    path('api/register/', register_user, name='register_user'),
    path('api/login/', login_user, name='login_user'),
]
urlpatterns += [
    path('swagger/', schema_view.with_ui('swagger', cache_timeout=0), name='schema-swagger-ui'),path('swagger.json', schema_view.without_ui(cache_timeout=0), name='schema-json'),
   # path('swagger.yaml', schema_view.without_ui(cache_timeout=0, renderer_classes=[ 'drf_yasg.renderers.OpenAPIRenderer',]), name='schema-yaml'),
]