import 'dart:async';

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
      );
      
      _messageRepository.sendMessage(message);
    });
  }
}

final messagesProvider = AsyncNotifierProvider<MessagesViewModel, void>(
  () => MessagesViewModel(),
);