import 'dart:developer';
import 'package:dr_ai/data/model/message_model.dart';
import 'package:dr_ai/view/widget/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/service/get_messae.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // List<Message> messagesList = [];
  List<UserMessage> userMessageList = []; //!
  int id = 1;
  late String data;
  void sendMessage() async {
    if (controller.text.isNotEmpty) {
      data = controller.text;
      log("Start");
      try {
        setState(() {
          userMessageList.add(UserMessage(data, id)); //!
          id++; //!
        });
        controller.clear();
        final response = await MessageService.postData(data: {'content': data});

        if (response != null) {
          setState(() {
            userMessageList.add(UserMessage(response.message, id)); //!
            id++; //!
            // messagesList.add(response);
          });
          log("End");
        }
      } catch (e) {
        log("response Error: $e");
      }
    }

    _controller.animateTo(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    // ignore: use_build_context_synchronously
    FocusScope.of(context).unfocus();
  }

  final _controller = ScrollController();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          "Chat",
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 200,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              reverse: false,
              controller: _controller,
              itemCount: userMessageList.length,
              itemBuilder: (context, index) {
                return index.isEven
                    ? ChatBubleForGest(message: userMessageList[index].message)
                    : ChatBubleForAi(message: userMessageList[index].message);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (_) {
                sendMessage();
              },
              decoration: InputDecoration(
                hintText: '  Write your message',
                suffixIcon: IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                  },
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(Icons.send),
                      color: Colors.green,
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    width: 3,
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
                    width: 3,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}