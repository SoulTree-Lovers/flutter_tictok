import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/features/authentication/repository/authentication_repository.dart';
import 'package:tictok_clone/utils/utils.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr build() {
    _authenticationRepository = ref.read(authRepositoryProvider);
  }

  Future<void> login(String email, String password, BuildContext context) async {
    state = AsyncValue.loading();

    // AsyncValue.guard: 에러가 없으면 결과값을 반환하고, 에러가 있으면 AsyncValue.error를 반환합니다.
    state = await AsyncValue.guard(
        () async => await _authenticationRepository.login(email, password));

    if (state.hasError) { // 에러가 있을 때 에러 메시지를 보여줍니다.
      showFirebaseErrorSnack(context, state.error);
    } else {
      // 에러가 없을 때 홈 화면으로 이동합니다.
      context.go('/home');
    }


    state = AsyncValue.data(null);
  }
}

final loginProvider =
    AsyncNotifierProvider<LoginViewModel, void>(() => LoginViewModel());
