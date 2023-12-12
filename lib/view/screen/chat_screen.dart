import 'package:dr_ai/core/helper/alert_message.dart';
import 'package:dr_ai/data/model/message_model.dart';
import 'package:dr_ai/logic/chat/chat_cubit.dart';
import 'package:dr_ai/view/widget/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController _scrollController = ScrollController();
void scrollToListEnd() {
  _scrollController.animateTo(
    _scrollController.position.maxScrollExtent,
    duration: const Duration(milliseconds: 100),
    curve: Curves.easeInOut,
  );
}
  bool isLoading = false;
  List<UserMessage> userMessageList = []; //!
  int id = 1;
  late String data;
  void sendMessage() async {
    if (controller.text.isNotEmpty) {
      data = controller.text;
      setState(() {
        userMessageList.add(UserMessage(data, id)); //!
        id++; //!
      });
      BlocProvider.of<ChatCubit>(context).sendMessage(data: data);
    }
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatLoading) {
          isLoading = true;
          controller.clear();
          // FocusScope.of(context).unfocus();
        }
        if (state is ChatSuccess) {
          isLoading = false;
          userMessageList.add(UserMessage(state.response, id));
          scrollToListEnd();
          id++;
        }
        if (state is ChatFailure) {
          isLoading = false;
          alertMessage(context);
        }
        //  else {
        //   isLoading = false;
        //   chatMessage(context);
        // }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
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
                  onSubmitted: (_) {
                    sendMessage();
                    scrollToListEnd();
                  },
                  decoration: InputDecoration(
                    hintText: '  Write your message',
                    suffixIcon: IconButton(
                      onPressed: () {
                        
                        sendMessage();
                      },
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.send,
                          color: Color(0xff00A859),
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
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: userMessageList.length,
              itemBuilder: (context, index) {
                return index.isEven
                    ? ChatBubbleForGuest(
                        message: userMessageList[index].message)
                    : ChatBubbleForDrAi(
                        message: userMessageList[index].message);
              },
            ),
          ),
        );
      },
    );
  }
}
