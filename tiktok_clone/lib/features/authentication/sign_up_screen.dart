import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/authentication/username_screen.dart';
import 'package:tictok_clone/features/authentication/viewmodels/social_auth_view_model.dart';
import 'package:tictok_clone/features/authentication/widgets/auth_button.dart';

import '../../generated/l10n.dart';
import 'login_screen.dart';

class SignUpScreen extends ConsumerWidget {
  static const String routeName = "sign_up";
  static const String routeUrl = "/";

  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    context.pushNamed(LoginScreen.routeName);
  }

  void _onEmailTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.landscape) {
          return Scaffold(
            body: Center(
              child: Text('Please rotate your device to portrait mode'),
            ),
          );
        }

        print("orientation: $orientation");
        return Scaffold(
          body: SafeArea(
            top: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
              child: Column(
                children: [
                  Gaps.v80,
                  Text(
                    // S.of(context).signUpTitle("TikTok", DateTime.now()),
                    "Sign up to TikTok",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Gaps.v20,
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      S.of(context).signUpSubtitle(2),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Sizes.size16,
                      ),
                    ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                      text: 'Use email & password',
                      icon: FaIcon(
                        FontAwesomeIcons.user,
                      ),
                      onTap: () => _onEmailTap(context),
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
                  if (orientation == Orientation.landscape) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AuthButton(
                            text: 'Use email & password',
                            icon: FaIcon(
                              FontAwesomeIcons.user,
                            ),
                            onTap: () => _onEmailTap(context),
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                            text: 'Continue with Facebook',
                            icon: FaIcon(
                              FontAwesomeIcons.facebook,
                            ),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
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
                      'Already have an account?',
                    ),
                    Gaps.h8,
                    InkWell(
                      onTap: () => _onLoginTap(context),
                      child: Text(
                        // S.of(context).logIn("male"),
                        'Log in',
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
      },
    );
  }
}
