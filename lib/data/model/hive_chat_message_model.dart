import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class ChatMessage extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String message;

  @HiveField(2)
  DateTime timeStamp;

  @HiveField(3)
  bool senderName;

  ChatMessage(
      {required this.id,
      required this.message,
      required this.timeStamp,
      required this.senderName});
}
