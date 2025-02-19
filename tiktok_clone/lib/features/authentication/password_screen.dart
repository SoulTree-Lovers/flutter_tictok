import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/authentication/birthday_screen.dart';
import 'package:tictok_clone/features/authentication/password_screen.dart';
import 'package:tictok_clone/features/authentication/viewmodels/signup_view_model.dart';
import 'package:tictok_clone/features/authentication/widgets/auth_text_field.dart';
import 'package:tictok_clone/features/authentication/widgets/form_button.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const  PasswordScreen({super.key});

  @override
  ConsumerState<PasswordScreen> createState() => PasswordScreenState();
}

class PasswordScreenState extends ConsumerState<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = "";
  bool _isObscureText = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    passwordControllerListener();
  }

  void passwordControllerListener() {
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  bool _isPasswordValid() {
    return _password.isNotEmpty && _password.length >= 8;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (_password.isEmpty || !_isPasswordValid()) {
      return;
    }

    final state = ref.read(signUpForm.notifier).state;

    ref.read(signUpForm.notifier).state = {
      ...state,
      "password": _password,
    };

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BirthdayScreen(),
      ),
    );
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void togglePasswordVisibility() {
    setState(() {
      _isObscureText = !_isObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Sign Up',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              Text(
                "Password",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v16,
              AuthTextField(
                controller: _passwordController,
                hintText: 'Make it strong!',
                errorText: _isPasswordValid()
                    ? null
                    : "Password must be at least 8 characters",
                onEditingComplete: _onSubmit,
                isEmailTextField: false,
                isObsecureText: _isObscureText,
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: _onClearTap,
                      child: FaIcon(
                        FontAwesomeIcons.solidCircleXmark,
                        size: Sizes.size20,
                      ),
                    ),
                    Gaps.h16,
                    InkWell(
                      onTap: togglePasswordVisibility,
                      child: FaIcon(
                        _isObscureText
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        color: Colors.grey.shade400,
                        size: Sizes.size20,
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.v16,
              Text(
                'Your password must have:',
                style: TextStyle(
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v8,
              Row(
                children: [
                  FaIcon(
                    _isPasswordValid()
                        ? FontAwesomeIcons.circleCheck
                        : FontAwesomeIcons.exclamation,
                    size: Sizes.size20,
                    color: _isPasswordValid() ? Colors.green : Colors.red,
                  ),
                  Gaps.h8,
                  Text(
                    'At least 8 characters',
                    style: TextStyle(
                      fontSize: Sizes.size14,
                    ),
                  ),
                ],
              ),
              Gaps.v16,
              FormButton(
                disabled: !_isPasswordValid(),
                onTap: _onSubmit,
                text: 'Next',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
