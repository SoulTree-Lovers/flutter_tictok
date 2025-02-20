import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/features/users/models/user_profile_model.dart';
import 'package:tictok_clone/features/users/repository/user_repository.dart';

class UserViewModel extends AsyncNotifier<UserProfileModel> {

  late final UserRepository _userRepository;

  @override
  FutureOr<UserProfileModel> build() {
    _userRepository = ref.read(userRepositoryProvider);
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential user) async {
    if (user.user == null) {
      throw Exception("Account creation failed");
    }

    state = AsyncValue.loading();

    final profile = UserProfileModel(
      bio: "undefined",
      link: "undefined",
      uid: user.user!.uid,
      name: user.user!.displayName ?? "Anonymous",
      email: user.user!.email ?? "undefined",
    );

    await _userRepository.createUser(profile);
    state = AsyncValue.data(profile);

  }
}

final userProvider = AsyncNotifierProvider<UserViewModel, UserProfileModel>(() => UserViewModel());
