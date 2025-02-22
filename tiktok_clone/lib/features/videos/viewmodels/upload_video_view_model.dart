import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/features/authentication/repository/authentication_repository.dart';
import 'package:tictok_clone/features/users/viewmodels/user_view_model.dart';
import 'package:tictok_clone/features/videos/models/video_model.dart';
import 'package:tictok_clone/features/videos/repository/videos_repository.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _videosRepository;

  @override
  FutureOr<void> build() {
    _videosRepository = ref.read(videosRepositoryProvider);
  }

  Future<void> uploadVideo(File video, BuildContext context) async {
    final uid = ref.read(authRepositoryProvider).user!.uid;
    final userProfile = ref.read(userProvider).value;

    if (userProfile == null) {
      throw Exception("User profile not found");
    }

    state = AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final task = await _videosRepository.uploadVideoFile(video, uid);
      if (task.metadata != null) {
        await _videosRepository.saveVideo(
          VideoModel(
            title: "From Flutter",
            description: "Uploaded from Flutter",
            fileUrl: await task.ref.getDownloadURL(),
            thumbnailUrl: "",
            creatorUid: uid,
            creatorName: userProfile.name,
            likes: 0,
            comments: 0,
            createdAt: DateTime.now().millisecondsSinceEpoch,
          ),
        );
        context.pushReplacement("/home");
      }
    });

    state = AsyncValue.data(null);
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);