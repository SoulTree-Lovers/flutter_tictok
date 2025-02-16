import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/authentication/username_screen.dart';
import 'package:tictok_clone/features/authentication/widgets/auth_button.dart';

import '../../generated/l10n.dart';
import 'login_screen.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeUrl = "/";
  static const String routeName = "sign_up";

  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => LoginScreen(),
    //   ),
    // );
    // Navigator.of(context).pushNamed(LoginScreen.routeName);
    context.push(LoginScreen.routeName);
  }

  void _onEmailTap(BuildContext context) {
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => UsernameScreen(),
    //   ),
    // );
    // Navigator.of(context).pushNamed(UsernameScreen.routeName);
    // context.push(UsernameScreen.routeName);
    context.pushNamed(UsernameScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
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
                    S.of(context).signUpTitle("TikTok", DateTime.now()),
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
                        S.of(context).logIn("male"),
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
