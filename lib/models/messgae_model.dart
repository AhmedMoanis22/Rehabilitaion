class MessageModel {
  String? senderId;
  String? receiverId;
  String? datetime;
  String? text;
  String? url;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.datetime,
    this.text,
    this.url
  });

  MessageModel.fromjason(Map<String, dynamic> jason) {
    senderId = jason['senderId'];
   url=jason['url'];

    receiverId = jason['receiverId'];
    datetime = jason['datetime'];
    text = jason['text'];
  }

  Map<String, dynamic> tojason() {
    return {
      'url':url,
      'senderId': senderId,
      'receiverId': receiverId,
      'datetime': datetime,
      'text': text,
    };
  }
}
