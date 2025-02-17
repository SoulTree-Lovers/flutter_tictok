import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tictok_clone/features/authentication/login_screen.dart';
import 'package:tictok_clone/features/authentication/sign_up_screen.dart';
import 'package:tictok_clone/features/inbox/activity_screen.dart';
import 'package:tictok_clone/features/inbox/chat_detail_screen.dart';
import 'package:tictok_clone/features/inbox/chats_screen.dart';
import 'package:tictok_clone/features/onboarding/interests_screen.dart';
import 'package:tictok_clone/features/videos/video_recording_screen.dart';

/*
* /signup
*   - Email (Navigator 1.0)
*   - Username (Navigator 1.0)
*   - Password (Navigator 1.0)
*   - Birthday (Navigator 1.0)
* /login
*   /login-form
* /onboarding
*   /onboarding-interest
*   /onboarding-tutorial
* /home
* /discover
* /inbox
* /profile
*
*/

final router = GoRouter(
  initialLocation: "/home",
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeUrl,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeUrl,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: InterestsScreen.routeName,
      path: InterestsScreen.routeUrl,
      builder: (context, state) => const InterestsScreen(),
    ),
    GoRoute(
      name: MainNavigationScreen.routeName,
      path: "/:tab(home|discover|inbox|profile)",
      builder: (context, state) {
        final tab = state.pathParameters['tab']!;
        return MainNavigationScreen(tab: tab);
      },
    ),
    GoRoute(
      name: ActivityScreen.routeName,
      path: ActivityScreen.routeUrl,
      builder: (context, state) => const ActivityScreen(),
    ),
    GoRoute(
      name: ChatsScreen.routeName,
      path: ChatsScreen.routeUrl,
      builder: (context, state) => const ChatsScreen(),
      routes: [
        GoRoute(
          name: ChatDetailScreen.routeName,
          path: ChatDetailScreen.routeUrl,
          builder: (context, state) {
            final chatId = state.pathParameters['chatId']!;
            return ChatDetailScreen(chatId: chatId);
          },
        ),
      ],
    ),
    GoRoute(
      name: VideoRecordingScreen.routeName,
      path: VideoRecordingScreen.routeUrl,
      builder: (context, state) {
        return VideoRecordingScreen();
      },
    ),
  ],
);
