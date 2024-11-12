from django.utils import timezone 
from django.db import models
from django.core.validators import MinValueValidator
from django.contrib.auth.models import User  # Assuming you're using the default User model
from django.contrib.auth.hashers import make_password, check_password
from django.contrib.auth.models import AbstractBaseUser, PermissionsMixin
from django.contrib.auth.models import BaseUserManager
from django.db import models

class CustomUserManager(BaseUserManager):
    def create_user(self, phone_num, password=None, **extra_fields):
        if not phone_num:
            raise ValueError("The Phone Number field must be set")
        user = self.model(phone_num=phone_num, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, phone_num, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        return self.create_user(phone_num, password, **extra_fields)

class User(AbstractBaseUser, PermissionsMixin):
    phone_num = models.CharField(max_length=15, unique=True)
    name = models.CharField(max_length=100)
    balance = models.DecimalField(max_digits=10, decimal_places=2, default=0.0)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)

    objects = CustomUserManager()

    USERNAME_FIELD = 'phone_num'
    REQUIRED_FIELDS = []
    
class UserSettings(models.Model):
    LANGUAGE_CHOICES = [
        ('en', 'English'),
        ('ar', 'Arabic'),
    ]
    CURRENCY_CHOICES = [
        ('USD', 'US Dollar'),
        ('EUR', 'Euro'),
        ('SAR', 'Saudi Riyal'),
    ]
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    dark_mode = models.BooleanField(default=False)
    language = models.CharField(
        max_length=2,
        choices=LANGUAGE_CHOICES,
        default='en'
    )
    currency = models.CharField(
        max_length=3,
        choices=CURRENCY_CHOICES,
        default='SAR'  # Default currency
    )
    
    def __str__(self):
        return f"{self.user.username}'s Settings"

class Account(models.Model):
    ACCOUNT_TYPE_CHOICES = [
        ('cash', 'Cash'),
        ('bank', 'Bank'),
        ('wallet', 'Digital Wallet'),
    ]
    
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='accounts')
    account_type = models.CharField(max_length=10, choices=ACCOUNT_TYPE_CHOICES)
    account_name = models.CharField(max_length=100)  # E.g., Bank name or Wallet provider
    account_number = models.CharField(max_length=50, blank=True, null=True)  # If applicable (for bank or wallet)
    balance = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)

    def __str__(self):
        return f"{self.account_type} - {self.account_name}"
    
class Transaction(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="transactions")  # Relationship to User
    date = models.DateTimeField(default=timezone.now, null=True, blank=True)  # Allows custom date or defaults to now
    amount = models.PositiveIntegerField(validators=[MinValueValidator(1)])  # Ensures positive amount
    is_expense = models.BooleanField(default=True)  # Default is true (expense)
    seller_name = models.CharField(max_length=128)  # Corrected typo in max_length
    account = models.ForeignKey('Account', on_delete=models.CASCADE, related_name="transactions")  # Separate ForeignKey to Account

    CURRENCY_CHOICES = [
        ('USD', 'US Dollar'),
        ('EUR', 'Euro'),
        ('SAR', 'Saudi Riyal'),
    ]

    EXPENSE_CHOICES = [
        ('FOOD_BEVERAGE', 'Food and Beverage'),
        ('SHOPPING', 'Shopping'),
        ('SUBSCRIPTION', 'Subscription'),
        ('HOUSEHOLD', 'Household'),
        ('TRANSPORTATION', 'Transportation'),
        ('EDUCATION', 'Education'),
        ('BILLS', 'Bills'),
        ('OTHER', 'Other'),
    ]

    INCOME_CHOICES = [
        ('SALARY', 'Salary'),
        ('INVESTMENTS', 'Investments'),
        ('GIFTS', 'Gifts'),
        ('OTHER', 'Other'),
    ]

    currency = models.CharField(
        max_length=3,
        choices=CURRENCY_CHOICES,
        default='SAR'  # Default currency
    )

    # Separate category fields for income and expense
    expense_category = models.CharField(
        max_length=20,
        choices=EXPENSE_CHOICES,
        blank=True,
        null=True,
    )
    
    income_category = models.CharField(
        max_length=20,
        choices=INCOME_CHOICES,
        blank=True,
        null=True,
    )

    def save(self, *args, **kwargs):
        # Enforce only one category field is set based on transaction type
        if self.is_expense:
            self.income_category = None
            if not self.expense_category:
                raise ValueError("Expense category must be set for expense transactions.")
        else:
            self.expense_category = None
            if not self.income_category:
                raise ValueError("Income category must be set for income transactions.")
        
        super().save(*args, **kwargs)

    def __str__(self):
        transaction_type = "Expense" if self.is_expense else "Income"
        return f"{transaction_type} of {self.amount} by {self.seller_name} on {self.date}"



    
# Base financial goal model
class FinancialGoal(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    goal_name = models.CharField(max_length=100)
    target_amount = models.DecimalField(max_digits=10, decimal_places=2)
    # other common fields for financial goals

    def __str__(self):
        return self.goal_name

# Specific goal type: Budget Goal for a certain period
class BudgetGoal(FinancialGoal):
    start_date = models.DateField()  # Start of the budget period
    end_date = models.DateField()  # End of the budget period
    current_expenses = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)  # Track expenses for the period

    class Meta:
        verbose_name = "Budget Goal"
        verbose_name_plural = "Budget Goals"

    def __str__(self):
        return f"Budget Goal {self.goal_name} from {self.start_date} to {self.end_date}"

# Specific goal type: Savings Goal for a specific purchase
class SavingsGoal(FinancialGoal):
    purchase_item = models.CharField(max_length=100)  # The item being saved for
    current_savings = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)  # Track current savings

    class Meta:
        verbose_name = "Savings Goal"
        verbose_name_plural = "Savings Goals"

    def __str__(self):
        return f"Savings Goal {self.goal_name} for {self.purchase_item}"
    



#chat models


class ChatSession(models.Model):
    """
    Tracks a user's chat session with the AI bot.
    """
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    started_at = models.DateTimeField(auto_now_add=True)
    ended_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"Chat Session {self.id} for {self.user.username}"


class Message(models.Model):
    """
    Stores individual messages in the chat.
    """
    chat_session = models.ForeignKey(ChatSession, related_name='messages', on_delete=models.CASCADE)
    sender = models.CharField(max_length=50, choices=[('user', 'User'), ('ai', 'AI')])
    content = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)
    is_user_message = models.BooleanField(default=False)  # True for user, False for AI response

    def __str__(self):
        return f"Message {self.id} ({'User' if self.is_user_message else 'AI'})"


class AIResponse(models.Model):
    """
    Stores AI-generated responses for further analysis or retraining (optional).
    """
    message = models.ForeignKey(Message, related_name='ai_responses', on_delete=models.CASCADE)
    response_content = models.TextField()
    generated_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"AI Response for Message {self.message.id}"