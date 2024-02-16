import 'package:dr_ai/core/helper/alert_message.dart';
import 'package:dr_ai/data/model/chat_message_model.dart';
import 'package:dr_ai/logic/chat/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/chat_buble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool isSenderLoading = false;
  bool isReceiverLoading = false;
  List<ChatMessageModel> chatMessageMode = [];
  TextEditingController controller = TextEditingController();

  void sendMessage() {
    if (controller.text.isNotEmpty) {
      BlocProvider.of<ChatCubit>(context).sendMessage(message: controller.text);
      setState(() {
        isSenderLoading = true;
      });
    }
  }

  @override
  void initState() {
    BlocProvider.of<ChatCubit>(context).recivedMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatSenderLoading) {
          setState(() {
            isSenderLoading = true;
            controller.clear();
          });
        }
        if (state is ChatSendSuccess) {
          setState(() {
            isSenderLoading = false;
            isReceiverLoading = true;
            if (controller.text.isNotEmpty) {
              BlocProvider.of<ChatCubit>(context).recivedMessage();
            }
          });
        }
        if (state is ChatReceiverLoading) {
          setState(() {
            isReceiverLoading = true;
          });
        }
        if (state is ChatReceiveSuccess) {
          setState(() {
            chatMessageMode = state.response;
            isReceiverLoading = false;
          });
        }
        if (state is ChatFailure) {
          setState(() {
            isSenderLoading = false;
            isReceiverLoading = false;
            alertMessage(context);
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff00A859),
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
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.viewInsetsOf(context).bottom),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 30, left: 30, top: 10, bottom: 20),
              child: TextField(
                controller: controller,
                onSubmitted: (_) => sendMessage(),
                decoration: InputDecoration(
                  hintText: '  Write your message',
                  suffixIcon: IconButton(
                    onPressed: () => sendMessage(),
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset(
                        "assets/images/send.png",
                        scale: 1.4,
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
                      color: Color(0xff00A859),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: chatMessageMode.length + (isReceiverLoading ? 1 : 0),
            reverse: true,
            itemBuilder: (context, index) {
              if (isReceiverLoading && index == 0) {
                return const ChatBubbleForDrAi(message: "loading...");
              } else {
                final chatIndex = isReceiverLoading ? index - 1 : index;
                final chatMessage = chatMessageMode[chatIndex];
                return chatMessage.isUser
                    ? ChatBubbleForGuest(message: chatMessage.message)
                    : ChatBubbleForDrAi(message: chatMessage.message);
              }
            },
          ),
        );
      },
    );
  }
}