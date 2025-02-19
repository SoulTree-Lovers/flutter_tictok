import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/features/authentication/repository/authentication_repository.dart';
import 'package:tictok_clone/features/onboarding/interests_screen.dart';
import 'package:tictok_clone/utils/utils.dart';

class SocialAuthViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<void> build() {
    _authenticationRepository = ref.read(authRepositoryProvider);
  }

  Future<void> githubSignIn(BuildContext context) async {
    state = AsyncValue.loading();

    state = await AsyncValue.guard(
      () async => await _authenticationRepository.githubSignIn(),
    );

    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.go("/home");
    }
  }
}

final socialAuthProvider =
    AsyncNotifierProvider<SocialAuthViewModel, void>(() => SocialAuthViewModel());