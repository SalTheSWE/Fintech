from django.db import models
from django.core.validators import MinValueValidator
from django.contrib.auth.models import User  # Assuming you're using the default User model
from django.contrib.auth.hashers import make_password, check_password

class User(models.Model):
    phone_num = models.CharField(max_length=15, unique=True)  # Changed to CharField for better flexibility
    password = models.CharField(max_length=128)  # Storing hashed passwords (Django handles this)

    def set_password(self, raw_password):
        """Hashes the password before saving."""
        self.password = raw_password(raw_password)

    def check_password(self, raw_password):
        """Checks if the password matches the stored hash."""
        return check_password(raw_password, self.password)

    def __str__(self):
        return f"User {self.phone_num}"


class Transaction(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name="transactions")  # Relationship to User
    date = models.DateTimeField(auto_now_add=True)  # Automatically sets the date when created
    amount = models.PositiveIntegerField(validators=[MinValueValidator(1)])  # Ensures positive amount
    is_expense = models.BooleanField(default=True)  # Default is true (expense)
    seller_name = models.CharField(max_length=128)  # Corrected typo in max_length

    def __str__(self):
        transaction_type = "Expense" if self.is_expense else "Income"
        return f"{transaction_type} of {self.amount} by {self.seller_name} on {self.date}"

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
    
# Base financial goal model
class FinancialGoal(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='financial_goals')
    goal_name = models.CharField(max_length=100)
    target_amount = models.DecimalField(max_digits=10, decimal_places=2, validators=[MinValueValidator(0.01)])
    is_completed = models.BooleanField(default=False)

    class Meta:
        abstract = True  # This is an abstract base class

# Specific goal type: Budget Goal for a certain period
class BudgetGoal(FinancialGoal):
    start_date = models.DateField()  # Start of the budget period
    end_date = models.DateField()  # End of the budget period
    current_expenses = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)  # Track expenses for the period

    def __str__(self):
        return f"Budget Goal {self.goal_name} from {self.start_date} to {self.end_date}"

# Specific goal type: Savings Goal for a specific purchase
class SavingsGoal(FinancialGoal):
    purchase_item = models.CharField(max_length=100)  # The item being saved for
    current_savings = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)  # Track current savings

    def __str__(self):
        return f"Savings Goal {self.goal_name} for {self.purchase_item}"