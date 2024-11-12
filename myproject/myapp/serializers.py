from rest_framework import serializers
from django.contrib.auth.hashers import make_password
from .models import User, Transaction, Account, BudgetGoal, SavingsGoal

class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = User
        fields = ['phone_num', 'password']

    def create(self, validated_data):
        # Hash the password before saving it
        password = validated_data.pop('password')
        user = User(**validated_data)
        user.password = make_password(password)
        user.save()
        return user


class TransactionSerializer(serializers.ModelSerializer):
    user = serializers.PrimaryKeyRelatedField(queryset=User.objects.all(), write_only=True)

    class Meta:
        model = Transaction
        fields = ['user', 'date', 'amount', 'is_expense', 'seller_name', "income_category", "expense_category", "account"]

    def create(self, validated_data):
        # Associate the transaction with the authenticated user
        user = self.context['request'].user  # Get the authenticated user
        validated_data['user'] = user  # Set the user on the transaction
        return super().create(validated_data)


class AccountSerializer(serializers.ModelSerializer):
    user = serializers.PrimaryKeyRelatedField(queryset=User.objects.all(), write_only=True)

    class Meta:
        model = Account
        fields = ['user', 'account_type', 'account_name', 'account_number', 'balance']

    def create(self, validated_data):
        # Associate the account with the authenticated user
        user = self.context['request'].user  # Get the authenticated user
        validated_data['user'] = user  # Set the user on the account
        return super().create(validated_data)


class BudgetGoalSerializer(serializers.ModelSerializer):
    user = serializers.PrimaryKeyRelatedField(queryset=User.objects.all(), write_only=True)

    class Meta:
        model = BudgetGoal
        fields = ['user', 'goal_name', 'target_amount', 'start_date', 'end_date', 'current_expenses']

    def create(self, validated_data):
        # Associate the goal with the authenticated user
        user = self.context['request'].user  # Get the authenticated user
        validated_data['user'] = user  # Set the user on the budget goal
        return super().create(validated_data)


class SavingsGoalSerializer(serializers.ModelSerializer):
    user = serializers.PrimaryKeyRelatedField(queryset=User.objects.all(), write_only=True)

    class Meta:
        model = SavingsGoal
        fields = ['user', 'goal_name', 'target_amount', 'purchase_item', 'current_savings']

    def create(self, validated_data):
        # Associate the goal with the authenticated user
        user = self.context['request'].user  # Get the authenticated user
        validated_data['user'] = user  # Set the user on the savings goal
        return super().create(validated_data)
