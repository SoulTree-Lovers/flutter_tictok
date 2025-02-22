import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/features/authentication/repository/authentication_repository.dart';
import 'package:tictok_clone/features/users/repository/user_repository.dart';
import 'package:tictok_clone/features/users/viewmodels/user_view_model.dart';

class AvatarViewModel extends AsyncNotifier<String?> {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  late final UserRepository _userRepository;

  @override
  FutureOr<String?> build() async {
    _userRepository = ref.read(userRepositoryProvider);
    final uid = ref.read(authRepositoryProvider).user?.uid;
    if (uid == null) return null;
    return await _getAvatarUrl(uid);
  }

  Future<void> uploadAvatar(File file) async {
    state = AsyncValue.loading();
    final uid = ref.read(authRepositoryProvider).user!.uid;
    final storageRef = _storage.ref().child('avatars/$uid.jpg');

    try {
      await storageRef.putFile(file);
      final downloadUrl = await storageRef.getDownloadURL();
      await _userRepository.updateAvatarUrl(uid, downloadUrl);
      await ref.read(userProvider.notifier).onAvatarUploaded(downloadUrl);
      state = AsyncValue.data(downloadUrl);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<String?> _getAvatarUrl(String uid) async {
    try {
      return await _storage.ref().child('avatars/$uid.jpg').getDownloadURL();
    } catch (_) {
      return null;
    }
  }
}

final avatarProvider = AsyncNotifierProvider<AvatarViewModel, String?>(() => AvatarViewModel());
