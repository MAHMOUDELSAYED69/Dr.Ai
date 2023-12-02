import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chat Page",
        ),
        backgroundColor: const Color(0xff00A859),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Chat Page",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff00A859)),
            ),
            Icon(
              Icons.chat,
              size: 50,
              color: Color(0xff00A859),
            )
          ],
        ),
      ),
    );
  }
}
