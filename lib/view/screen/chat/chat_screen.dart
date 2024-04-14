import 'package:dr_ai/core/constant/image.dart';
import 'package:dr_ai/core/helper/custom_dialog.dart';
import 'package:dr_ai/core/helper/extention.dart';
import 'package:dr_ai/logic/chat/chat_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../core/constant/color.dart';
import '../../../data/model/chat_message_model.dart';
import '../../widget/chat_buble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isSenderLoading = false;
  bool _isReceiverLoading = false;
  List<ChatMessageModel> chatMessageMode = [];
  late TextEditingController _controller;

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      BlocProvider.of<ChatCubit>(context)
          .sendMessage(message: _controller.text);
      setState(() {
        _isSenderLoading = true;
      });
    }
  }

  @override
  void initState() {
    _controller = TextEditingController();
    context.bloc<ChatCubit>().recivedMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.bloc<ChatCubit>();
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatSenderLoading) {
          _isSenderLoading = true;
          _controller.clear();
        }
        if (state is ChatSendSuccess) {
          _isSenderLoading = false;
          if (_controller.text.isNotEmpty) {
            cubit.recivedMessage();
          }
        }
        if (state is ChatReceiverLoading) {
          _isReceiverLoading = true;
        }
        if (state is ChatReceiveSuccess) {
          _isReceiverLoading = false;
          chatMessageMode = state.response;
        }
        if (state is ChatFailure) {
          _isSenderLoading = false;
          _isReceiverLoading = false;
          alertMessage(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Doctor AI Chat",
              style: context.textTheme.bodyMedium?.copyWith(fontSize: 18.spMin),
            ),
            shape: context.appBarTheme.shape,
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.viewInsetsOf(context).bottom),
            child: Padding(
              padding: EdgeInsets.only(
                  right: 18.w, left: 18.w, top: 10.h, bottom: 16.h),
              child: _buildChatTextField(context),
            ),
          ),
          body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: chatMessageMode.length + (_isReceiverLoading ? 1 : 0),
            reverse: true,
            itemBuilder: (context, index) {
              if (_isReceiverLoading && index == 0) {
                return const ChatBubbleForLoading();
              } else {
                final chatIndex = _isReceiverLoading ? index - 1 : index;
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

  Widget _buildChatTextField(BuildContext context) {
    return TextField(
      style: context.textTheme.bodySmall?.copyWith(color: ColorManager.black),
      cursorColor: ColorManager.green,
      controller: _controller,
      onSubmitted: (_) => _sendMessage(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        filled: context.inputDecoration.filled,
        fillColor: context.inputDecoration.fillColor,
        hintStyle: context.inputDecoration.hintStyle,
        hintText: 'Write Your Message..',
        suffixIcon: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(ImageManager.recordIcon)),
            IconButton(
                onPressed: _sendMessage,
                icon: Icon(
                  Icons.send,
                  color: ColorManager.green,
                  size: 25.r,
                )),
          ],
        ),
        enabledBorder: context.inputDecoration.border,
        focusedBorder: context.inputDecoration.border,
      ),
    );
  }
}
