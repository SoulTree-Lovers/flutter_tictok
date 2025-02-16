import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/features/authentication/email_screen.dart';
import 'package:tictok_clone/features/authentication/login_screen.dart';
import 'package:tictok_clone/features/authentication/sign_up_screen.dart';
import 'package:tictok_clone/features/authentication/username_screen.dart';
import 'package:tictok_clone/features/users/user_profile_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeUrl,
      builder: (context, state) => SignUpScreen(),
      routes: [
        GoRoute(
          name: UsernameScreen.routeName,
          path: UsernameScreen.routeUrl,
          // builder: (context, state) => UsernameScreen(),
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: UsernameScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: animation,
                    child: child,
                  ),
                );
              },
            );
          },
          routes: [
            GoRoute(
              name: EmailScreen.routeName,
              path: EmailScreen.routeUrl,
              builder: (context, state) {
                var extra = state.extra as EmailScreenArgs;
                return EmailScreen(username: extra.username);
              },
            ),
          ],
        ),

      ],
    ),
    // GoRoute(
    //   path: LoginScreen.routeName,
    //   builder: (context, state) => LoginScreen(),
    // ),
    GoRoute(
      path: "/users/:username",
      builder: (context, state) {
        final username = state.pathParameters['username'];
        var tab = state.uri.queryParameters['show'];
        return UserProfileScreen(username: username!, tab: tab!);
      },
    ),
  ],
);
