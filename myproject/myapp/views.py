from django.shortcuts import render
from django.shortcuts import render, redirect
from django.contrib.auth import login
from .forms import RegistrationForm
from rest_framework import viewsets
from .models import Transaction
from .serializers import TransactionSerializer
from rest_framework.permissions import IsAuthenticated
from rest_framework import viewsets
from .models import Account
from .serializers import AccountSerializer
from rest_framework.permissions import IsAuthenticated
from rest_framework import viewsets
from .models import BudgetGoal, SavingsGoal
from .serializers import BudgetGoalSerializer, SavingsGoalSerializer
from rest_framework.permissions import IsAuthenticated

from django.contrib.auth.hashers import make_password, check_password
from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from .models import User
from .serializers import UserSerializer

@api_view(['POST'])
def register_user(request):
    """Register a new user."""
    phone_num = request.data.get('phone_num')
    password = request.data.get('password')

    if not phone_num or not password:
        return Response({"error": "Phone number and password are required."}, status=status.HTTP_400_BAD_REQUEST)

    # Hash password
    hashed_password = make_password(password)
    
    # Create user
    user = User(phone_num=phone_num, password=hashed_password)
    user.save()

    return Response({"message": "User registered successfully."}, status=status.HTTP_201_CREATED)

@api_view(['POST'])
def login_user(request):
    """Authenticate user."""
    phone_num = request.data.get('phone_num')
    password = request.data.get('password')

    try:
        user = User.objects.get(phone_num=phone_num)
    except User.DoesNotExist:
        return Response({"error": "User not found."}, status=status.HTTP_404_NOT_FOUND)

    if check_password(password, user.password):
        return Response({"message": "Login successful."}, status=status.HTTP_200_OK)
    else:
        return Response({"error": "Invalid password."}, status=status.HTTP_400_BAD_REQUEST)
    
class TransactionViewSet(viewsets.ModelViewSet):
    """CRUD for transactions."""
    queryset = Transaction.objects.all()
    serializer_class = TransactionSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        # Return only the transactions for the authenticated user
        return Transaction.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        # Associate the transaction with the logged-in user
        serializer.save(user=self.request.user)


class AccountViewSet(viewsets.ModelViewSet):
    """CRUD for user accounts."""
    queryset = Account.objects.all()
    serializer_class = AccountSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        # Return only the accounts for the authenticated user
        return Account.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        # Associate the account with the logged-in user
        serializer.save(user=self.request.user)     

class BudgetGoalViewSet(viewsets.ModelViewSet):
    """CRUD for budget goals."""
    queryset = BudgetGoal.objects.all()
    serializer_class = BudgetGoalSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return BudgetGoal.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

class SavingsGoalViewSet(viewsets.ModelViewSet):
    """CRUD for savings goals."""
    queryset = SavingsGoal.objects.all()
    serializer_class = SavingsGoalSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return SavingsGoal.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)
