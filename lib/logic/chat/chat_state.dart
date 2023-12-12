part of '../chat/chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final String response;

  ChatSuccess({required this.response});
}

class ChatFailure extends ChatState {
  final String message;
  ChatFailure({required this.message});
}
