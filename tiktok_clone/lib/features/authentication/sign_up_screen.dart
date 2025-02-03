import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/authentication/widgets/auth_button.dart';

import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            children: [
              Gaps.v80,
              Text(
                'Sign Up for TikTok',
                style: TextStyle(
                  fontSize: Sizes.size28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              Text(
                'Create a profile, follow other accounts, make your own videos, and more.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.black45,
                ),
              ),
              Gaps.v40,
              AuthButton(
                text: 'Use phone or email',
                icon: FaIcon(
                  FontAwesomeIcons.user,
                ),
              ),
              Gaps.v16,
              AuthButton(
                text: 'Continue with Facebook',
                icon: FaIcon(
                  FontAwesomeIcons.facebook,
                ),
              ),
              Gaps.v16,
              AuthButton(
                text: 'Continue with Apple',
                icon: FaIcon(
                  FontAwesomeIcons.apple,
                ),
              ),
              Gaps.v16,
              AuthButton(
                text: 'Continue with Google',
                icon: FaIcon(
                  FontAwesomeIcons.google,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: Sizes.size60 * 2,
        child: BottomAppBar(
          color: Colors.grey.shade200,
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account?',
                ),
                Gaps.h8,
                InkWell(
                  onTap: () => onLoginTap(context),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
