import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/features/users/models/user_profile_model.dart';

class UserRepository {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // create user
  Future<void> createUser(UserProfileModel user) async {
    // create user
    _firestore.collection("user").doc(user.uid).set(user.toJson());
  }

  // get user

  // update user


}

final userRepositoryProvider = Provider((ref) {
  return UserRepository();
});