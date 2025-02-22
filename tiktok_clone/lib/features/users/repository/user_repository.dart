import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/features/users/models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // create user
  Future<void> createUser(UserProfileModel user) async {
    await _firestore.collection("user").doc(user.uid).set(user.toJson());
  }

  // get user
  Future<Map<String, dynamic>?> getUser(String uid) async {
    final user = await _firestore.collection("user").doc(uid).get();
    return user.data();
  }

  // update user
  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _firestore.collection("user").doc(uid).update(data);
  }

  // upload avatar and update user profile with the new URL
  Future<String> uploadAvatar(File file, String uid) async {
    final fileRef = _storage.ref().child("avatars/$uid.jpg");
    await fileRef.putFile(file);

    // Get the download URL
    final downloadUrl = await fileRef.getDownloadURL();

    // Update the user's avatar URL in Firestore
    await updateAvatarUrl(uid, downloadUrl);

    return downloadUrl;
  }

  // update avatar URL in Firestore
  Future<void> updateAvatarUrl(String uid, String avatarUrl) async {
    await _firestore.collection("user").doc(uid).update({
      'avatarUrl': avatarUrl,
    });
  }
}

final userRepositoryProvider = Provider((ref) {
  return UserRepository();
});