# Generated by Django 5.1.1 on 2024-11-10 14:25

import django.utils.timezone
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0003_user_name'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='usersettings',
            name='default_currency',
        ),
        migrations.AddField(
            model_name='transaction',
            name='currency',
            field=models.CharField(choices=[('USD', 'US Dollar'), ('EUR', 'Euro'), ('SAR', 'Saudi Riyal')], default='SAR', max_length=3),
        ),
        migrations.AddField(
            model_name='transaction',
            name='expense_category',
            field=models.CharField(blank=True, choices=[('FOOD_BEVERAGE', 'Food and Beverage'), ('SHOPPING', 'Shopping'), ('SUBSCRIPTION', 'Subscription'), ('HOUSEHOLD', 'Household'), ('TRANSPORTATION', 'Transportation'), ('EDUCATION', 'Education'), ('BILLS', 'Bills'), ('OTHER', 'Other')], max_length=20, null=True),
        ),
        migrations.AddField(
            model_name='transaction',
            name='income_category',
            field=models.CharField(blank=True, choices=[('SALARY', 'Salary'), ('INVESTMENTS', 'Investments'), ('GIFTS', 'Gifts'), ('OTHER', 'Other')], max_length=20, null=True),
        ),
        migrations.AddField(
            model_name='usersettings',
            name='currency',
            field=models.CharField(choices=[('USD', 'US Dollar'), ('EUR', 'Euro'), ('SAR', 'Saudi Riyal')], default='SAR', max_length=3),
        ),
        migrations.AlterField(
            model_name='transaction',
            name='date',
            field=models.DateTimeField(blank=True, default=django.utils.timezone.now, null=True),
        ),
        migrations.AlterField(
            model_name='usersettings',
            name='language',
            field=models.CharField(choices=[('en', 'English'), ('ar', 'Arabic')], default='en', max_length=2),
        ),
    ]
