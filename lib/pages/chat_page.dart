import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String recieversEmail;
  const ChatPage({super.key, required this.recieversEmail});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.recieversEmail),
        ),
      ),
    );
  }
}
