import 'package:flutter/material.dart';

import '../../models/message_model.dart';

class ChatBubleForAi extends StatelessWidget {
  ChatBubleForAi({
    Key? key,
    required this.message,
  }) : super(key: key);

  // final Message message;      ابقي شيل الكومنتدا واشتغل عليه
  String message; //ابقي شيل دا انا عامله عشان اشل Ui
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius:const  BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
          color: Colors.grey[200],
        ),
        child: Text(
          // message.message,
          message,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class ChatBubleForGest extends StatelessWidget {
  const ChatBubleForGest({
    Key? key,
    required this.message,
  }) : super(key: key);

  // final Message message;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
            topLeft: Radius.circular(50),
            bottomLeft: Radius.circular(50),
          ),
          color: Colors.green,
        ),
        child: Text(
          message,
          // message.message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
