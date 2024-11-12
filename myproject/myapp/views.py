from django.shortcuts import render, redirect
from django.contrib.auth import login
from django.contrib.auth.hashers import make_password, check_password
from rest_framework import viewsets, status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework.permissions import IsAuthenticated

from .models import User, Transaction, Account, BudgetGoal, SavingsGoal
from .serializers import (
    UserSerializer, 
    TransactionSerializer, 
    AccountSerializer, 
    BudgetGoalSerializer, 
    SavingsGoalSerializer
)


@api_view(['POST'])
def register_user(request):
    """Register a new user."""
    phone_num = request.data.get('phone_num')
    password = request.data.get('password')
    name = request.data.get("name")
    if not phone_num or not password:
        return Response({"error": "Phone number and password are required."}, status=status.HTTP_400_BAD_REQUEST)

    # Check if user already exists
    if User.objects.filter(phone_num=phone_num).exists():
        return Response({"error": "User with this phone number already exists."}, status=status.HTTP_400_BAD_REQUEST)

    # Hash password
    hashed_password = make_password(password)
    
    # Create user
    user = User(phone_num=phone_num, password=hashed_password, name=name)
    user.save()

    return Response({"message": "User registered successfully."}, status=status.HTTP_201_CREATED)

from rest_framework.authtoken.models import Token
from rest_framework.response import Response

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
        # Create or fetch the token for the user
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
