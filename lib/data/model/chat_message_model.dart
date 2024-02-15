class ChatMessageModel {
  final bool isUser;
  final String message;
  final String timeTamp;

  ChatMessageModel(
      {required this.isUser, required this.message, required this.timeTamp});

  factory ChatMessageModel.fromJson(Map<String, dynamic> jsonData) {
    return ChatMessageModel(
        isUser: jsonData['isUser'],
        message: jsonData['message'],
        timeTamp: jsonData['timeTamp']);
  }
  Map<String, dynamic> toJson() {
    return {
      'isUser': isUser,
      'message': message,
      'timeTamp': timeTamp,
    };
  }
}
