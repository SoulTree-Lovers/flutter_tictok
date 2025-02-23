import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/features/authentication/repository/authentication_repository.dart';
import 'package:tictok_clone/features/videos/repository/videos_repository.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {

  late final VideosRepository _videosRepository;
  late final _videoId;

  @override
  FutureOr<void> build(String videoId) {
    _videoId = videoId;
    _videosRepository = ref.read(videosRepositoryProvider);
  }

  Future<void> likeVideo() async {
    final user = ref.read(authRepositoryProvider).user;
    await _videosRepository.likeVideo(_videoId, user!.uid);
  }

}

final videoPostProvider = AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  () => VideoPostViewModel(),
);