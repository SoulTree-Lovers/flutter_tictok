class MessageModel {
  final String text;
  final String senderUid;
  final int createdAt;

  MessageModel({
    required this.text,
    required this.senderUid,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'senderUid': senderUid,
      'createdAt': createdAt,
    };
  }

  MessageModel.fromJson(Map<String, dynamic> json)
      : text = json['text'],
        senderUid = json['senderUid'],
        createdAt = json['createdAt'];
}