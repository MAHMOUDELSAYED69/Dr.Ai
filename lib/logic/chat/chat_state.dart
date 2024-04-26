part of '../chat/chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatSenderLoading extends ChatState {}

class ChatReceiverLoading extends ChatState {}

class ChatSendSuccess extends ChatState {}

class ChatReceiveSuccess extends ChatState {
  final dynamic response;

  ChatReceiveSuccess({required this.response});
}

class ChatFailure extends ChatState {
  final String message;
  ChatFailure({required this.message});
}

class ClearChatLoading extends ChatState {}

class ClearChatSuccess extends ChatState {
  final String message;
  ClearChatSuccess({required this.message});
}

class ClearChatFailure extends ChatState {
  final String message;
  ClearChatFailure({required this.message});
}

