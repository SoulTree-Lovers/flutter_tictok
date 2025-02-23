import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/features/inbox/models/message_model.dart';

class MessageRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(MessageModel message) async {
    await _firestore.collection("chat_rooms").doc("e2dU3WoX9Wy43dF4OSri").collection("texts").add(message.toJson());
  }
}

final messageRepositoryProvider = Provider<MessageRepository>((ref) {
  return MessageRepository();
});
