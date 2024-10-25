import 'package:flutter/material.dart';
import 'package:social_app/features/chat/presentation/widgets/body_chat_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: const BodyChatPage(),
    );
  }
}
