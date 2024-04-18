import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_ai/data/model/chat_message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import '../../data/service/api/py_message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  dynamic response;
  final _firestore = FirebaseFirestore.instance
      .collection('chat_history')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('messages');
  Future<void> sendMessage({required String message}) async {
    emit(ChatSenderLoading());
    try {
      ChatMessageModel chatMessageModel = ChatMessageModel(
          isUser: true,
          message: message.trim(),
          timeTamp: DateTime.now().toString());
      await _firestore.add(chatMessageModel.toJson());
      emit(ChatSendSuccess());
      emit(ChatReceiverLoading());
      response = await MessageWebService.postData(data: {'content': message});
      log(response.toString());
      await recivedMessage();
      response = null;
      emit(ChatSendSuccess());
    } on Exception catch (err) {
      emit(ChatFailure(message: err.toString()));
    }
  }

  Future<void> recivedMessage() async {
    try {
      if (response != null) {
        ChatMessageModel chatMessageModel = ChatMessageModel(
            isUser: false,
            message: response ?? "ERROR",
            timeTamp: DateTime.now().toString());
        await _firestore.add(chatMessageModel.toJson());
      }
      _firestore
          .orderBy(
            'timeTamp',
            descending: true,
          )
          .snapshots()
          .listen((event) {
        List<ChatMessageModel> chatMessageModel = [];
        for (var doc in event.docs) {
          chatMessageModel.add(ChatMessageModel.fromJson(doc.data()));
        }
        emit(ChatReceiveSuccess(response: chatMessageModel));
      });
    } on FirebaseException catch (err) {
      emit(ChatFailure(message: err.toString()));
      log(err.toString());
    }
  }

  Future<void> clearMessages() async {
    emit(ClearChatLoading());
    try {
      final QuerySnapshot querySnapshot = await _firestore.get();
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      emit(ClearChatSuccess(message: "All messages deleted successfully."));
    } on Exception catch (err) {
      emit(ClearChatFailure(message: err.toString()));
    }
  }
}
