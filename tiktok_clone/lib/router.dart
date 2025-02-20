import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tictok_clone/features/authentication/login_screen.dart';
import 'package:tictok_clone/features/authentication/repository/authentication_repository.dart';
import 'package:tictok_clone/features/authentication/sign_up_screen.dart';
import 'package:tictok_clone/features/inbox/activity_screen.dart';
import 'package:tictok_clone/features/inbox/chat_detail_screen.dart';
import 'package:tictok_clone/features/inbox/chats_screen.dart';
import 'package:tictok_clone/features/onboarding/interests_screen.dart';
import 'package:tictok_clone/features/videos/views/video_recording_screen.dart';

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

final routerProvider = Provider(
  (ref) {

    // ref.watch(authStateStream);

    return GoRouter(
      initialLocation: "/home",
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepositoryProvider).isLoggedIn;

        // 유저가 로그인하지 않았을 때, 로그인 페이지로 리다이렉트
        if (!isLoggedIn &&
            state.matchedLocation != SignUpScreen.routeUrl &&
            state.matchedLocation != LoginScreen.routeUrl) {
          return SignUpScreen.routeUrl;
        }
        return null;
      },
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
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              transitionDuration: const Duration(milliseconds: 200),
              child: VideoRecordingScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 1),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
      ],
    );
  },
);
