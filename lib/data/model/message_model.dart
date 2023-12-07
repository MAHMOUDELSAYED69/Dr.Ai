class Message {
  final String message;
  Message(
    this.message,
  );
  factory Message.fromJson(jsonData) {
    return Message(jsonData['message']);
  }
}

class UserMessage {
  final String message;
  final int id;
  UserMessage(
    this.message,
    this.id,
  );
}
