import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/model/chat_message_model.dart';
import '../../data/service/api/py_message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  CollectionReference? _messagesCollection;
  StreamSubscription<QuerySnapshot>? _messagesSubscription;

  ChatCubit() : super(ChatInitial()) {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        _messagesCollection = FirebaseFirestore.instance
            .collection('chat_history')
            .doc(user.uid)
            .collection('messages');
        startListeningToMessages();
      } else {
        _messagesSubscription?.cancel();
        _messagesCollection = null;
      }
    });
  }

  void startListeningToMessages() {
    if (_messagesCollection != null) {
      _messagesSubscription?.cancel();
      _messagesSubscription = _messagesCollection!
          .orderBy('timeTamp', descending: true)
          .snapshots()
          .listen((snapshot) {
        final messages = snapshot.docs
            .map((doc) =>
                ChatMessageModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        emit(ChatReceiveSuccess(response: messages));
      }, onError: (error) {
        emit(ChatFailure(message: error.toString()));
      });
    }
  }

  Future<void> sendMessage({required String message}) async {
    if (_messagesCollection != null) {
      emit(ChatSenderLoading());
      try {
        final chatMessageModel = ChatMessageModel(
            isUser: true,
            message: message.trim(),
            timeTamp: DateTime.now().toString());
        await _messagesCollection!.add(chatMessageModel.toJson());
        emit(ChatSendSuccess());

        //send message to bot
        emit(ChatReceiverLoading());
        final response =
            await MessageWebService.postData(data: {'content': message});
        log(response.toString());
        await _messagesCollection!.add(ChatMessageModel(
          isUser: false,
          message: response ?? "ERROR",
          timeTamp: DateTime.now().toString(),
        ).toJson());
        emit(ChatSendSuccess());
      } on Exception catch (err) {
        emit(ChatFailure(message: err.toString()));
      }
    }
  }

  Future<void> deleteChatHistory() async {
    if (_messagesCollection != null) {
      emit(ChatDeletingLoading());
      try {
        final messagesQuerySnapshot = await _messagesCollection!.get();

        for (var doc in messagesQuerySnapshot.docs) {
          await _messagesCollection!.doc(doc.id).delete();
        }
        emit(ChatDeleteSuccess());
      } on FirebaseException catch (_) {
        emit(ChatDeleteFailure(message: "Failed to delete chat history"));
      }
    }
  }
}