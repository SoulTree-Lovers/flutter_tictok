import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/features/authentication/repository/authentication_repository.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<void> build() {
    _authenticationRepository = ref.read(authRepositoryProvider);
  }

  Future<void> signUp() async {
    state = AsyncValue.loading();
    final form = ref.read(signUpForm);

    await _authenticationRepository.signUp(
      form["email"],
      form["password"],
    );

    state = AsyncValue.data(null);
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(() => SignUpViewModel());