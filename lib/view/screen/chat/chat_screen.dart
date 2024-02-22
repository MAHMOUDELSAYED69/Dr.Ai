import 'package:dr_ai/core/constant/image.dart';
import 'package:dr_ai/core/helper/alert_message.dart';
import 'package:dr_ai/data/model/chat_message.dart';
import 'package:dr_ai/logic/chat/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constant/color.dart';
import '../../widget/chat_buble.dart';

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
          isSenderLoading = true;
          controller.clear();
        }
        if (state is ChatSendSuccess) {
          isSenderLoading = false;
          if (controller.text.isNotEmpty) {
            BlocProvider.of<ChatCubit>(context).recivedMessage();
          }
        }
        if (state is ChatReceiverLoading) {
          isReceiverLoading = true;
        }
        if (state is ChatReceiveSuccess) {
          isReceiverLoading = false;
          chatMessageMode = state.response;
        }
        if (state is ChatFailure) {
          isSenderLoading = false;
          isReceiverLoading = false;
          alertMessage(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              backgroundColor: MyColors.white,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
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
              elevation: 0,
              shadowColor: Colors.grey[50]),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.viewInsetsOf(context).bottom),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 25, left: 25, top: 10, bottom: 20),
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      blurRadius: 20,
                      offset: const Offset(5, 4),
                      spreadRadius: 0,
                      color: MyColors.black.withOpacity(0.13))
                ]),
                child: TextField(
                  cursorColor: MyColors.green,
                  controller: controller,
                  onSubmitted: (_) => sendMessage(),
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.only(top: 19, bottom: 19, left: 12),
                    filled: true,
                    fillColor: MyColors.white,
                    hintText: '  Write your message',
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            MyImages.mic,
                            scale: 1.4,
                          ),
                        ),
                        IconButton(
                          onPressed: () => sendMessage(),
                          icon: Image.asset(
                            MyImages.send,
                            scale: 1.4,
                          ),
                        ),
                        const Gap(10),
                      ],
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30),
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
                return const ChatBubbleForLoading();
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
