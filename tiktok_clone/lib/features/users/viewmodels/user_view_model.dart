import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/features/authentication/repository/authentication_repository.dart';
import 'package:tictok_clone/features/users/models/user_profile_model.dart';
import 'package:tictok_clone/features/users/repository/user_repository.dart';

class UserViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    await Future.delayed(Duration(seconds: 3));

    _userRepository = ref.read(userRepositoryProvider);
    _authenticationRepository = ref.read(authRepositoryProvider);

    if (_authenticationRepository.isLoggedIn) {
      final user = await _userRepository.getUser(_authenticationRepository.user!.uid);

      if (user != null) {
        return UserProfileModel.fromJson(user);
      }
    }

    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential user) async {
    if (user.user == null) {
      throw Exception("Account creation failed");
    }

    state = AsyncValue.loading();

    final profile = UserProfileModel(
      hasAvatar: false,
      avatarUrl: "", // 추가됨
      bio: "undefined",
      link: "undefined",
      uid: user.user!.uid,
      name: user.user!.displayName ?? "Anonymous",
      email: user.user!.email ?? "undefined",
    );

    await _userRepository.createUser(profile);
    state = AsyncValue.data(profile);
  }

  Future<void> onAvatarUploaded(String downloadUrl) async {
    final updatedProfile = state.value!.copyWith(
      hasAvatar: true,
      avatarUrl: downloadUrl,
    );

    state = AsyncValue.data(updatedProfile);

    await _userRepository.updateUser(state.value!.uid, {
      'hasAvatar': true,
      'avatarUrl': downloadUrl,
    });
  }
}

final userProvider = AsyncNotifierProvider<UserViewModel, UserProfileModel>(() => UserViewModel());
