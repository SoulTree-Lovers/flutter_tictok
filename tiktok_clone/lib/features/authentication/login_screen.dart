import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/authentication/email_screen.dart';
import 'package:tictok_clone/features/authentication/login_form_screen.dart';
import 'package:tictok_clone/features/authentication/viewmodels/social_auth_view_model.dart';
import 'package:tictok_clone/features/authentication/widgets/auth_button.dart';

class LoginScreen extends ConsumerWidget {
  static const String routeName = "login";
  static const String routeUrl = "/login";

  const LoginScreen({super.key});

  void _onSignUpTap(BuildContext context) {
    context.pop();
  }

  void _onEmailLoginTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            children: [
              Gaps.v80,
              Text(
                'Log in to TikTok',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Gaps.v16,
              Opacity(
                opacity: 0.7,
                child: Text(
                  'Manage your account, check notifications, comment on videos, and more.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Sizes.size14,
                  ),
                ),
              ),
              Gaps.v40,
              AuthButton(
                text: 'Use email & password',
                icon: FaIcon(
                  FontAwesomeIcons.user,
                ),
                onTap: () => _onEmailLoginTap(context),
              ),
              Gaps.v16,
              AuthButton(
                text: 'Continue with Github',
                icon: FaIcon(
                  FontAwesomeIcons.github,
                ),
                onTap: () => ref.read(socialAuthProvider.notifier).githubSignIn(context),
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
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                ),
                Gaps.h8,
                InkWell(
                  onTap: () => _onSignUpTap(context),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
