class MessageModel {
  final String text;
  final String senderUid;

  MessageModel({
    required this.text,
    required this.senderUid,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'senderUid': senderUid,
    };
  }

  factory MessageModel.fromJson({required Map<String, dynamic> json}) {
    return MessageModel(
      text: json['text'],
      senderUid: json['senderUid'],
    );
  }
}