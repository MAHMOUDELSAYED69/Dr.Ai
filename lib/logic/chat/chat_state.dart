part of '../chat/chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSendSuccess extends ChatState {}

class ChatReceiveSuccess extends ChatState {
  final dynamic response;

  ChatReceiveSuccess({required this.response});
}

class ChatFailure extends ChatState {
  final String message;
  ChatFailure({required this.message});
}
