from rest_framework import serializers
from .models import User, Transaction, Account, BudgetGoal, SavingsGoal

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['phone_num', 'password']

class TransactionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Transaction
        fields = ['user', 'date', 'amount', 'is_expense', 'seller_name']

class AccountSerializer(serializers.ModelSerializer):
    class Meta:
        model = Account
        fields = ['user', 'account_type', 'account_name', 'account_number', 'balance']

class BudgetGoalSerializer(serializers.ModelSerializer):
    class Meta:
        model = BudgetGoal
        fields = ['user', 'goal_name', 'target_amount', 'start_date', 'end_date', 'current_expenses', 'is_completed']

class SavingsGoalSerializer(serializers.ModelSerializer):
    class Meta:
        model = SavingsGoal
        fields = ['user', 'goal_name', 'target_amount', 'purchase_item', 'current_savings', 'is_completed']
