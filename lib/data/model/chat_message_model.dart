import 'package:hive/hive.dart';
part 'chat_message_model.g.dart';

@HiveType(typeId: 0)
class ChatMessageModel {
  @HiveField(0)
  final bool isUser;
  @HiveField(1)
  final String message;
  @HiveField(2)
  final String timeTamp;

  ChatMessageModel({
    required this.isUser,
    required this.message,
    required this.timeTamp,
  });
}
