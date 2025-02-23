import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/features/authentication/repository/authentication_repository.dart';
import 'package:tictok_clone/features/inbox/chats_screen.dart';
import 'package:tictok_clone/features/videos/views/video_recording_screen.dart';

class NotificationsProvider extends FamilyAsyncNotifier<void, BuildContext> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> updateToken(String token) async {
    final user = ref.read(authRepositoryProvider).user;
    print("user: ${user!.uid}");
    await _firestore.collection("user").doc(user!.uid).update({
      "token": token,
    });
  }

  Future<void> initListeners(BuildContext context) async {
    final permission = await _firebaseMessaging.requestPermission();
    if (permission.authorizationStatus == AuthorizationStatus.denied) {
      return;
    }

    // Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("I got a message foreground");
      print(event.notification?.title);
    });

    // Background
    FirebaseMessaging.onMessageOpenedApp.listen((notification) {
      print(notification.data['screen']);
      context.pushNamed(ChatsScreen.routeName);
    });

    // Terminated
    final notification = await _firebaseMessaging.getInitialMessage();
    if (notification != null) {
      print(notification.data['screen']);
      context.pushNamed(VideoRecordingScreen.routeName);
    }
  }

  @override
  FutureOr build(BuildContext context) async {
    final token = await _firebaseMessaging.getToken();
    print("token: $token");

    if (token == null) return;
    await updateToken(token);

    await initListeners(context);

    _firebaseMessaging.onTokenRefresh.listen((newToken) async {
      await updateToken(newToken);
    });
  }
}

final notificationsProvider = AsyncNotifierProvider.family(
  () => NotificationsProvider(),
);
