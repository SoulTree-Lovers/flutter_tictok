import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/authentication/username_screen.dart';
import 'package:tictok_clone/features/authentication/widgets/auth_button.dart';

import 'email_screen.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UsernameScreen(),
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
                text: 'Use email & password',
                icon: FaIcon(
                  FontAwesomeIcons.user,
                ),
                onTap: () => _onEmailTap(context),
              ),
              Gaps.v16,
              AuthButton(
                text: 'Continue with Facebook',
                icon: FaIcon(
                  FontAwesomeIcons.facebook,
                ),
                onTap: () {},
              ),
              Gaps.v16,
              AuthButton(
                text: 'Continue with Apple',
                icon: FaIcon(
                  FontAwesomeIcons.apple,
                ),
                onTap: () {},
              ),
              Gaps.v16,
              AuthButton(
                text: 'Continue with Google',
                icon: FaIcon(
                  FontAwesomeIcons.google,
                ),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: Sizes.size60 * 2,
        child: BottomAppBar(
          color: Colors.grey.shade50,
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
                  onTap: () => _onLoginTap(context),
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
