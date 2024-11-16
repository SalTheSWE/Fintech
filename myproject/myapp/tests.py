from django.test import TestCase
from rest_framework.authtoken.models import Token
from rest_framework.test import APIClient
from rest_framework import status
from django.urls import reverse
from django.contrib.auth.hashers import make_password
from .models import User, Transaction, Account, BudgetGoal, SavingsGoal
import json
from channels.testing import WebsocketCommunicator
from channels.layers import get_channel_layer
from myproject.asgi import application
from myapp.models import ChatSession, Message


# Sample test for User registration and login
class UserApiTest(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.user_data = {
            'phone_num': '123456789',
            'password': 'password',
            'name': 'Test User'
        }

    def test_register_user(self):
        url = reverse('register_user')
        response = self.client.post(url, self.user_data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertIn('message', response.data)
        self.assertEqual(response.data['message'], 'User registered successfully.')

    def test_login_user(self):
        user = User.objects.create(phone_num='123456789', password=make_password('password'), name='Test User')
        url = reverse('login_user')
        response = self.client.post(url, {'phone_num': user.phone_num, 'password': 'password'}, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data['message'], 'Login successful.')

    def test_login_user_invalid(self):
        user = User.objects.create(phone_num='123456789', password=make_password('password'), name='Test User')
        url = reverse('login_user')
        response = self.client.post(url, {'phone_num': user.phone_num, 'password': 'wrongpassword'}, format='json')
        self.assertEqual(response.status_code, status.HTTP_400_BAD_REQUEST)
        self.assertIn('error', response.data)

# Test for Transaction view (CRUD operations)
class TransactionApiTest(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.user = User.objects.create(phone_num='123456789', password=make_password('password'), name='Test User')
        self.account = Account.objects.create(user = self.user, account_type = "cash", account_name = "testaccount", balance = 0)
        self.client.force_authenticate(user=self.user)
        self.transaction_data = {'amount': 100, 'is_expense': False, 'seller_name': 'Store A', "user": self.user.id, "income_category": "OTHER" , "account":self.account.id}

    def test_create_transaction(self):
        url = reverse('transaction-list')  # URL for TransactionViewSet
        response = self.client.post(url, self.transaction_data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response.data['amount'], 100)

    def test_get_transactions(self):
        # Create a transaction first
        self.client.post(reverse('transaction-list'), self.transaction_data, format='json')
        url = reverse('transaction-list')
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        

    def test_unauthorized_transaction_access(self):
        self.client.logout()  # Force logout
        response = self.client.get(reverse('transaction-list'))
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

# Test for Account view (CRUD operations)
class AccountApiTest(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.user = User.objects.create(phone_num='123456789', password=make_password('password'), name='Test User')
        self.client.force_authenticate(user=self.user)
        self.account_data = {
            'account_type': 'cash',
            'account_name': 'Test Account',
            'account_number': '1234567890',
            'balance': 1000,
            "user": self.user.id
        }

    def test_create_account(self):
        url = reverse('account-list')
        response = self.client.post(url, self.account_data, format='json')
        # Assert the status code is 201 CREATED
        print("Response Data:", response.data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_get_accounts(self):
        self.client.post(reverse('account-list'), self.account_data, format='json')
        url = reverse('account-list')
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        

# Test for Budget Goal view (CRUD operations)
class BudgetGoalApiTest(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.user = User.objects.create(phone_num='123456789', password=make_password('password'), name='Test User')
        self.client.force_authenticate(user=self.user)
        self.budget_goal_data = {
            'goal_name': 'Monthly Budget',
            'target_amount': 1500,
            'start_date': '2024-01-01',
            'end_date': '2024-12-31',
            'current_expenses': 0,
            'is_completed': False,
            "user": self.user.id

        }

    def test_create_budget_goal(self):
        url = reverse('budgetgoal-list')  # URL for BudgetGoalViewSet
        response = self.client.post(url, self.budget_goal_data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response.data['goal_name'], 'Monthly Budget')

    def test_get_budget_goals(self):
        self.client.post(reverse('budgetgoal-list'), self.budget_goal_data, format='json')
        url = reverse('budgetgoal-list')
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        

# Test for Savings Goal view (CRUD operations)
class SavingsGoalApiTest(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.user = User.objects.create(phone_num='123456789', password=make_password('password'), name='Test User')
        self.client.force_authenticate(user=self.user)
        self.savings_goal_data = {
            'goal_name': 'Vacation Fund',
            'target_amount': 2000,
            'purchase_item': 'Vacation to Hawaii',
            'current_savings': 0,
            'is_completed': False,
            'user': self.user.id

        }

    def test_create_savings_goal(self):
        url = reverse('savingsgoal-list')  # URL for SavingsGoalViewSet
        response = self.client.post(url, self.savings_goal_data, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response.data['goal_name'], 'Vacation Fund')

    def test_get_savings_goals(self):
        self.client.post(reverse('savingsgoal-list'), self.savings_goal_data, format='json')
        url = reverse('savingsgoal-list')
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        

# Test for checking if permissions are applied correctly
class TestPermissions(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.user = User.objects.create(phone_num='123456789', password=make_password('password'), name='Test User')
       

    def test_unauthorized_access(self):
        url = reverse('transaction-list')  # Example URL
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_authorized_access(self):
        self.client.force_authenticate(user=self.user)
        url = reverse('transaction-list')  # Example URL
        response = self.client.get(url)
        self.assertEqual(response.status_code, status.HTTP_200_OK)



# tests for chat function 
class ChatConsumerTest(TestCase):
    def setUp(self):
        # Create a test user for WebSocket communication
        self.user = User.objects.create(phone_num='123456789', password=make_password('password'), name='Test User')
        self.session = ChatSession.objects.create(user=self.user)
        self.chat_session_id = self.session.id

    async def test_websocket_connection(self):
        # Establish WebSocket connection using WebsocketCommunicator
        communicator = WebsocketCommunicator(application, f"/ws/chat/{self.chat_session_id}/")
        connected, subprotocol = await communicator.connect()

        # Ensure the WebSocket connection is established
        self.assertTrue(connected)

        # Receive the initial message from the WebSocket (welcome message or prompt)
        response = await communicator.receive_json_from()
        self.assertEqual(response['message'], 'Welcome to the AI chatbot. How can I assist you?')

        # Send a message to the WebSocket (simulating user message)
        await communicator.send_json_to({'message': 'Hello AI'})

        # Receive the response from the AI
        response = await communicator.receive_json_from()
        self.assertTrue(response['message'].startswith('AI Response: You said'))

        # Optionally, check that the message was stored in the database
        user_message = Message.objects.get(sender='user', content='Hello AI')
        ai_message = Message.objects.get(sender='ai', content='AI Response: You said \'Hello AI\'')

        self.assertIsNotNone(user_message)
        self.assertIsNotNone(ai_message)

        # Close the WebSocket connection
        await communicator.disconnect()

    async def test_websocket_disconnect(self):
        # Establish WebSocket connection using WebsocketCommunicator
        communicator = WebsocketCommunicator(application, f"/ws/chat/{self.chat_session_id}/")
        connected, subprotocol = await communicator.connect()

        # Ensure the WebSocket connection is established
        self.assertTrue(connected)

        # Disconnect the WebSocket and verify no errors
        await communicator.disconnect()

        # Optionally, check the session status
        session = ChatSession.objects.get(id=self.chat_session_id)
        self.assertIsNotNone(session.ended_at)  # Assuming you are updating the `ended_at` field on disconnect

