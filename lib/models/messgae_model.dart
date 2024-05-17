class MessageModel {
  String? senderId;
  String? receiverId;
  String? datetime;
  String? text;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.datetime,
    this.text,
  });

  MessageModel.fromjason(Map<String, dynamic> jason) {
    senderId = jason['senderId'];

    receiverId = jason['receiverId'];
    datetime = jason['datetime'];
    text = jason['text'];
  }

  Map<String, dynamic> tojason() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'datetime': datetime,
      'text': text,
    };
  }
}
