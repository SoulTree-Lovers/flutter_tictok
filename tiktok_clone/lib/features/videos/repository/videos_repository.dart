import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/features/videos/models/video_model.dart';

class VideosRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // upload video
  UploadTask uploadVideoFile(File video, String uid) {
    final fileRef = _storage.ref().child(
        "videos/$uid/${DateTime.now().millisecondsSinceEpoch.toString()}");
    return fileRef.putFile(video);
  }

  Future<void> saveVideo(VideoModel video) async {
    await _firestore.collection("videos").add(video.toJson());
  }

  // fetch videos
  Future<QuerySnapshot<Map<String, dynamic>>> fetchVideos(
      {
    int? lastItemCreatedAt,
  }) {
    final query = _firestore
        .collection("videos")
        .orderBy("createdAt", descending: true)
        .limit(2);

    if (lastItemCreatedAt != null) {
      return query.get();
    } else {
      return query.startAfter([lastItemCreatedAt]).get();
    }
  }

// create video document
}

final videosRepositoryProvider = Provider<VideosRepository>((ref) {
  return VideosRepository();
});
