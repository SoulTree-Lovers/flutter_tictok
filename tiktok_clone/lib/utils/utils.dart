import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

bool isDarkMode(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark;
}

void showFirebaseErrorSnack(BuildContext context, Object? error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // action: SnackBarAction(
      //   label: "OK",
      //   onPressed: () {
      //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
      //   },
      // ),
      showCloseIcon: true,
      content: Text((error as FirebaseException).message ?? "Something went wrong"),
    ),
  );
}