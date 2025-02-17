import 'package:flutter/material.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/authentication/password_screen.dart';
import 'package:tictok_clone/features/authentication/widgets/auth_text_field.dart';
import 'package:tictok_clone/features/authentication/widgets/form_button.dart';

class EmailScreenArgs {
  final String username;

  EmailScreenArgs({
    required this.username,
  });
}

class EmailScreen extends StatefulWidget {
  final String username;

  const EmailScreen({
    super.key, required this.username,
  });

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _emailController = TextEditingController();

  String _email = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    emailControllerListener();
  }

  void emailControllerListener() {
    _emailController.addListener(() {
      setState(() {
        _email = _emailController.text;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  String? _isEmailValid() {
    if (_email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    /*

    ^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_{|}~]+`: 이메일 주소의 로컬 부분을 나타냅니다. 여기에는 영문자, 숫자, 점, 그리고 다양한 특수 문자가 포함될 수 있습니다.
    @: 로컬 부분과 도메인 부분을 구분하는 "@" 기호입니다.
    [a-zA-Z0-9]+: 도메인 이름의 첫 번째 부분을 나타냅니다. 여기에는 영문자와 숫자가 포함될 수 있습니다.
    \.: 도메인 이름의 각 부분을 구분하는 점입니다.
    [a-zA-Z]+$: 도메인 이름의 마지막 부분을 나타냅니다. 여기에는 영문자가 포함될 수 있습니다.

    예시 이메일 양식:
    example@example.com
    user.name+tag+sorting@example.com
    user_name@example.co.uk

    */
    if (!regExp.hasMatch(_email)) {
      return "Please enter a valid email";
    }
    return null;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (_email.isEmpty || _isEmailValid() != null) {
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PasswordScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as EmailScreenArgs;

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
                "What is your email, ${widget.username}?",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v8,
              Text(
                "You can always change this later.",
                style: TextStyle(
                  fontSize: Sizes.size16,
                ),
              ),
              Gaps.v16,
              AuthTextField(
                controller: _emailController,
                hintText: 'Email',
                errorText: _isEmailValid(),
                onEditingComplete: _onSubmit,
                isEmailTextField: true,
              ),
              Gaps.v16,
              FormButton(
                disabled: _email.isEmpty || _isEmailValid() != null,
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
