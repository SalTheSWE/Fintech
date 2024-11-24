from rest_framework import serializers
from django.contrib.auth.hashers import make_password
from .models import User, Transaction, Account, BudgetGoal, SavingsGoal, UserSettings
from .models import Message,ChatSession

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

class UserSettingsSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserSettings
        fields = ['id', 'user', 'dark_mode', 'language', 'currency']
        read_only_fields = ['user']  # Prevent the user field from being updated directly

    # Optional validation for `language` and `currency` fields (choices are already enforced by the model)
    def validate_language(self, value):
        if value not in dict(UserSettings.LANGUAGE_CHOICES):
            raise serializers.ValidationError("Invalid language choice.")
        return value

    def validate_currency(self, value):
        if value not in dict(UserSettings.CURRENCY_CHOICES):
            raise serializers.ValidationError("Invalid currency choice.")
        return value

class TransactionSerializer(serializers.ModelSerializer):
    user = serializers.PrimaryKeyRelatedField(queryset=User.objects.all(), write_only=True)

    class Meta:
        model = Transaction
        fields = ['user', 'date', 'amount', 'is_expense', 'seller_name', "income_category", "expense_category", "account"]
    def validate(self, data):
        """
        Check that the account belongs to the same user as the transaction.
        """
        account = data.get('account')
        user = data.get('user')

        # If no account or user is provided, we can't perform the validation
        if account and user:
            if account.user != user:
                raise serializers.ValidationError("You can only make transactions on your own accounts.")

        return data   

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


class MessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Message
        fields = ['id', 'chat_session', 'sender', 'content', 'is_user_message', 'timestamp']
        read_only_fields = ['id', 'timestamp']


class ChatSessionSerializer(serializers.ModelSerializer):
    messages = MessageSerializer(many=True, read_only=True)

    class Meta:
        model = ChatSession
        fields = ['id', 'user', 'messages']
        read_only_fields = ['id', 'user']




class SendMessageSerializer(serializers.Serializer):
    message = serializers.CharField()

    def validate_message(self, value):
        if not value.strip():
            raise serializers.ValidationError("Message cannot be empty.")
        return value
    


class CreateChatSessionSerializer(serializers.ModelSerializer):
    class Meta:
        model = ChatSession
        fields = ['id', 'user']

    def create(self, validated_data):
        return ChatSession.objects.create(**validated_data)

