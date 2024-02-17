import 'package:dr_ai/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ChatBubbleForLoading extends StatelessWidget {
  const ChatBubbleForLoading({super.key});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          height: 45,
          width: 60,
          padding:
              const EdgeInsets.only(left: 16, top: 10, bottom: 10, right: 10),
          margin:
              const EdgeInsets.only(left: 16, top: 8, bottom: 16, right: 100),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            color: Colors.grey[200],
          ),
          child: const LoadingIndicator(
            indicatorType: Indicator.ballPulse,
            colors: [MyColors.green, MyColors.white,MyColors.selver],
          )),
    );
  }
}

class ChatBubbleForDrAi extends StatelessWidget {
  const ChatBubbleForDrAi({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, top: 10, bottom: 10, right: 10),
        margin: const EdgeInsets.only(left: 16, top: 8, bottom: 16, right: 100),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(25),
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          color: Colors.grey[200],
        ),
        child: Text(
          message,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 18,
            color: MyColors.black,
          ),
        ),
      ),
    );
  }
}

class ChatBubbleForGuest extends StatelessWidget {
  const ChatBubbleForGuest({
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
            const EdgeInsets.only(left: 16, top: 10, bottom: 10, right: 10),
        margin: const EdgeInsets.only(left: 100, top: 8, bottom: 16, right: 16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            topLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          color: MyColors.green,
        ),
        child: Text(
          message,
          // message.message,
          style: const TextStyle(
            fontSize: 18,
            color: MyColors.white,
          ),
        ),
      ),
    );
  }
}
