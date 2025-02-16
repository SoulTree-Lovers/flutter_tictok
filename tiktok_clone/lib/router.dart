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
      path: SignUpScreen.routeName,
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
        name: "username_screen",
        path: UsernameScreen.routeName,
        // builder: (context, state) => UsernameScreen(),
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            child: UsernameScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation,
                  child: child,
                ),
              );
            },
          );
        }),
    GoRoute(
      path: EmailScreen.routeName,
      builder: (context, state) {
        var extra = state.extra as EmailScreenArgs;
        return EmailScreen(username: extra.username);
      },
    ),
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
