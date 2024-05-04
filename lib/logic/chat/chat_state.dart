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

class ChatDeletingLoading extends ChatState {}

class ChatDeleteSuccess extends ChatState {}

class ChatDeleteFailure extends ChatState {
  final String? message;
  ChatDeleteFailure({this.message});
}