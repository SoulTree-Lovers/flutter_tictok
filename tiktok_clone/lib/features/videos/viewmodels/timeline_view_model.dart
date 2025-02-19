import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/features/videos/models/video_model.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _videos = [
    VideoModel(
      title: "Video 1",
    ),
  ];

  void uploadVideo() async {
    state = AsyncValue.loading();
    await Future.delayed(Duration(seconds: 2));
    final video = VideoModel(
      title: "${DateTime.now()}"
    );
    _videos = [..._videos, video];
    state = AsyncValue.data(_videos);
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    // Future<모델>을 반환하는 비동기 함수 (실제 API 호출)
    await Future.delayed(Duration(seconds: 2));
    // throw Exception("Error");

    return _videos;
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
