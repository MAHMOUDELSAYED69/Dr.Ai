import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/chat_buble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static String id = 'ChatPage';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
            icon: const Icon(Icons.arrow_back_ios_new)),
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
              reverse: true,
              controller: _controller,
              itemCount: 10,
              itemBuilder: (context, index) {
                return ChatBubleForAi(
                  message:
                      "test glhilg ae;giergleujghluighguiwjlgjn;aeioguaepgio;ghiegepuogihogihpg'uaghkae0guae",
                );
//   اشتغل علي الكومنتات دي شيل الكومنت وعدل عليه
                //  messagesList[index].id == email ?  ChatBuble(
                //   message: messagesList[index],
                // ) : ChatBubleForFriend(message: messagesList[index]);
              },
            ),
            /////////
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                // messages.add(
                //   {kMessage: data, kCreatedAt: DateTime.now(), 'id': email},
                // );
                controller.clear();
                _controller.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                    color: Colors.green,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(
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
