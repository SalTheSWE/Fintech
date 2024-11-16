# your_app_name/consumers.py
import json
from channels.generic.websocket import AsyncWebsocketConsumer
from django.contrib.auth.models import User
from .models import ChatSession, Message
from channels.auth import get_user
from channels.db import database_sync_to_async
 # Assuming you are using OpenAI for AI responses

 # Replace with your actual API key
@database_sync_to_async
def get_actual_user(user_lazy_obj):
    return user_lazy_obj if user_lazy_obj.is_authenticated else None

@database_sync_to_async
def get_or_create_chat_session(user):
    chat_session, created = ChatSession.objects.get_or_create(user=user)
    return chat_session

@database_sync_to_async
def save_user_message(chat_session, user_message):
    return Message.objects.create(
        chat_session=chat_session,
        sender='user',
        content=user_message,
        is_user_message=True
    )

@database_sync_to_async
def save_ai_message(chat_session, ai_response):
    return Message.objects.create(
        chat_session=chat_session,
        sender='ai',
        content=ai_response,
        is_user_message=False
    )

class ChatConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        # Get the session ID from the URL
        self.session_id = self.scope['url_route']['kwargs']['session_id']
        # Get the actual user object from the scope
        self.user = await get_actual_user(self.scope["user"])

        # Ensure the user is authenticated
        if not self.user:
            # Reject the WebSocket connection if the user is not authenticated
            await self.close()

        # Check if the chat session exists or create a new one
        self.chat_session = await get_or_create_chat_session(self.user)

        # Accept the WebSocket connection
        await self.accept()

        # Send initial message or welcome (if necessary)
        await self.send(text_data=json.dumps({
            'message': 'Welcome to the AI chatbot. How can I assist you?'
        }))

    async def receive(self, text_data):
        # Receive message from WebSocket
        text_data_json = json.loads(text_data)
        user_message = text_data_json['message']

        # Store the user's message in the database
        await save_user_message(self.chat_session, user_message)

        # Get AI's response
        ai_response = await self.get_ai_response(user_message)

        # Store the AI's response in the database
        await save_ai_message(self.chat_session, ai_response)

        # Send the AI response back to the WebSocket
        await self.send(text_data=json.dumps({
            'message': ai_response
        }))

    async def disconnect(self, close_code):
        # Perform any necessary cleanup when the WebSocket is closed
        pass

    # Async method to mock AI response for testing
    async def get_ai_response_mock(self, user_message):
        return f"AI Response: You said '{user_message}'"

    # You can replace this with a real AI service like OpenAI or others
    async def get_ai_response(self, user_message):
        # Mock AI response for testing purposes
        return await self.get_ai_response_mock(user_message)
