import 'dart:developer';
import 'package:dr_ai/core/helper/scaffold_snakbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:dr_ai/logic/chat/chat_cubit.dart';
import 'package:dr_ai/data/model/chat_message_model.dart';
import 'package:gap/gap.dart';
import '../../widget/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constant/color.dart';
import '../../../core/helper/custom_dialog.dart';
import '../../../core/helper/extention.dart';
import '../../../core/constant/image.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  bool _isSenderLoading = false;
  bool _isReceiverLoading = false;
  bool _isChatDeletingLoading = false;
  bool _isButtonVisible = false;
  List<ChatMessageModel> _chatMessageModel = [];
  late TextEditingController _txtController = TextEditingController();
  late ScrollController _scrollController;
  String _currentLocaleId = 'ar-EG';

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _getMessages();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      bool isAtBottom = _scrollController.position.pixels <= 100;
      if (!isAtBottom) {
        if (!_isButtonVisible) {
          setState(() {
            _isButtonVisible = true;
          });
        }
      } else {
        if (_isButtonVisible) {
          setState(() {
            _isButtonVisible = false;
          });
        }
      }
    });
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      partialResults: true,
      onSoundLevelChange: null,
      cancelOnError: true,
      localeId: _currentLocaleId,
      listenMode: stt.ListenMode.dictation,
    );
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      _txtController.text = _lastWords;
      _txtController.selection = TextSelection.fromPosition(
        TextPosition(offset: _txtController.text.length),
      );
    });
    log(result.recognizedWords);
  }

  void _sendMessage() {
    if (_txtController.text.isNotEmpty) {
      context.read<ChatCubit>().sendMessage(message: _txtController.text);
      _txtController.clear();
    }
  }

  void onSelected(value) {
    if (value == 'delete') {
      context.read<ChatCubit>().deleteAllMessages();
    }
  }

  void _getMessages() async {
    if (_chatMessageModel.isEmpty) await context.read<ChatCubit>().initHive();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is ChatSenderLoading) {
          setState(() {
            _isSenderLoading = true;
            _txtController.clear();
          });
        }
        if (state is ChatSendSuccess) {
          _isSenderLoading = false;
        }
        if (state is ChatReceiverLoading) {
          _isReceiverLoading = true;
        }
        if (state is ChatReceiveSuccess) {
          _isReceiverLoading = false;
          _chatMessageModel = state.response;
          _scrollToEnd();
        }
        if (state is ChatFailure) {
          _isSenderLoading = false;
          _isReceiverLoading = false;
          alertMessage(context);
        }
        if (state is ChatDeletingLoading) {
          _isChatDeletingLoading = true;
        }
        if (state is ChatDeleteSuccess) {
          _isChatDeletingLoading = false;
          customSnackBar(context, "Chat History Deleted Successfully.",
              ColorManager.green, 1);
        }
        if (state is ChatDeleteFailure) {
          _isChatDeletingLoading = false;
          customSnackBar(context, "Chat History Deleted Successfully.",
              ColorManager.green);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Doctor AI Chat"),
            shape: context.appBarTheme.shape,
            actions: [
              _buildPopupMenuButton(),
            ],
          ),
          floatingActionButton:
              _isButtonVisible ? _buildFloatingActionButton() : null,
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: EdgeInsets.only(
                  right: 18.w, left: 18.w, top: 10.h, bottom: 16.h),
              child: _buildChatTextField(context),
            ),
          ),
          body: _chatMessageModel.isEmpty
              ? _buildEmptyChatBackgroud()
              : _isChatDeletingLoading
                  ? _buildLoadingIndicator()
                  : _buildMessages(),
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        width: 50.w,
        height: 50.w,
        decoration: BoxDecoration(
          color: ColorManager.green.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: SizedBox(
          width: 25.w,
          height: 25.w,
          child: const CircularProgressIndicator(
            strokeCap: StrokeCap.round,
            color: ColorManager.white,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyChatBackgroud() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            ImageManager.chatIcon,
            width: 100.w,
            height: 100.h,
            // ignore: deprecated_member_use
            color: ColorManager.green,
          ),
          Gap(16.h),
          Text("Start Chatting With Dr. AI",
              style: context.textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildMessages() {
    return ListView.builder(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      itemCount: _chatMessageModel.length + (_isReceiverLoading ? 1 : 0),
      reverse: true,
      itemBuilder: (context, index) {
        if (_isReceiverLoading && index == 0) {
          return const ChatBubbleForLoading();
        } else {
          final chatIndex = _isReceiverLoading ? index - 1 : index;
          final chatMessage = _chatMessageModel[chatIndex];
          return chatMessage.isUser
              ? ChatBubbleForGuest(message: chatMessage.message)
              : ChatBubbleForDrAi(
                  message: chatMessage.message,
                  time: chatMessage.timeTamp,
                );
        }
      },
    );
  }

  Widget _buildChatTextField(BuildContext context) {
    return TextField(
      minLines: 1,
      maxLines: 4,
      style: context.textTheme.bodySmall?.copyWith(color: ColorManager.black),
      cursorColor: ColorManager.green,
      controller: _txtController,
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
            if (_speechToText.isNotListening)
              IconButton(
                onPressed: _startListening,
                icon: SvgPicture.asset(ImageManager.recordIcon),
              ),
            if (_speechToText.isListening)
              IconButton(
                onPressed: _stopListening,
                icon: const Icon(Icons.stop, color: Colors.red),
              ),
            IconButton(
              onPressed: () => _sendMessage(),
              icon: Icon(
                Icons.send,
                color: ColorManager.green,
                size: 25.r,
              ),
            ),
          ],
        ),
        enabledBorder: context.inputDecoration.border,
        focusedBorder: context.inputDecoration.border,
      ),
    );
  }

  PopupMenuButton _buildPopupMenuButton() {
    return PopupMenuButton<String>(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.r),
      ),
      padding: EdgeInsets.zero,
      onSelected: onSelected,
      offset: const Offset(0, 40),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            height: 28.h,
            value: 'delete',
            child: Text('Clear Chat History',
                style: context.textTheme.bodySmall
                    ?.copyWith(color: ColorManager.black)),
          ),
        ];
      },
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.small(
      splashColor: ColorManager.white.withOpacity(0.3),
      elevation: 2,
      onPressed: _scrollToEnd,
      backgroundColor: ColorManager.green,
      child: const Icon(
        Icons.keyboard_double_arrow_down_rounded,
        color: ColorManager.white,
      ),
    );
  }

  void _scrollToEnd() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 700),
        curve: Curves.fastOutSlowIn,
      );
    }
  }
}
