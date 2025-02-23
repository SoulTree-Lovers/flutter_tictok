import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/features/authentication/repository/authentication_repository.dart';
import 'package:tictok_clone/features/inbox/models/message_model.dart';
import 'package:tictok_clone/features/inbox/repository/message_repository.dart';

class MessagesViewModel extends AsyncNotifier<void> {
  late final MessageRepository _messageRepository;

  @override
  FutureOr<void> build() {
    _messageRepository = ref.read(messageRepositoryProvider);
  }

  Future<void> sendMessage(String text) async {
    final user = ref.read(authRepositoryProvider).user;
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final message = MessageModel(
        text: text,
        senderUid: user!.uid,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );

      await _messageRepository.sendMessage(message);
    });
  }
}

final messagesProvider = AsyncNotifierProvider<MessagesViewModel, void>(
  () => MessagesViewModel(),
);

final chatProvider = StreamProvider.autoDispose<List<MessageModel>>((ref) {
  final firestore = FirebaseFirestore.instance;

  return firestore
      .collection("chat_rooms")
      .doc("e2dU3WoX9Wy43dF4OSri")
      .collection("texts")
      .orderBy("createdAt")
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (doc) => MessageModel.fromJson(
                doc.data(),
              ),
            )
            .toList()
            .reversed
            .toList(),
      );
});
