# your_app_name/consumers.py
import json
from channels.generic.websocket import AsyncWebsocketConsumer
from django.contrib.auth.models import User
from .models import ChatSession, Message
import openai  # Assuming you are using OpenAI for AI responses

openai.api_key = 'your-api-key'  # Replace with your actual API key

class ChatConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        # Get the session ID from the URL
        self.session_id = self.scope['url_route']['kwargs']['session_id']
        self.user = self.scope['user']  # Get the user connected

        # Check if the chat session exists or create a new one
        chat_session, created = ChatSession.objects.get_or_create(user=self.user)

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
        chat_session = ChatSession.objects.get(id=self.session_id)
        user_message_instance = Message.objects.create(
            chat_session=chat_session,
            sender='user',
            content=user_message,
            is_user_message=True
        )

        # Get AI's response
        ai_response = await self.get_ai_response(user_message)

        # Store the AI's response in the database
        ai_message_instance = Message.objects.create(
            chat_session=chat_session,
            sender='ai',
            content=ai_response,
            is_user_message=False
        )

        # Send the AI response back to the WebSocket
        await self.send(text_data=json.dumps({
            'message': ai_response
        }))

    async def disconnect(self, close_code):
        # Perform any necessary cleanup when the WebSocket is closed
        pass

    async def get_ai_response(self, user_message):
        # Make a request to an AI model to get a response (e.g., OpenAI API)
        response = openai.Completion.create(
            engine="text-davinci-003",  # Or use another AI model
            prompt=user_message,
            max_tokens=150
        )
        return response.choices[0].text.strip()
    

    async def get_ai_response_mock(self, user_message):
         return f"AI Response: You said '{user_message}'"

