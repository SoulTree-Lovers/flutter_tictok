import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/features/videos/models/video_model.dart';
import 'package:tictok_clone/features/videos/repository/videos_repository.dart';

class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  late final VideosRepository _videosRepository;

  List<VideoModel> _videos = [];

  Future<List<VideoModel>> _fetchVideos({int? lastItemCreatedAt}) async {
    final result = await _videosRepository.fetchVideos(lastItemCreatedAt: null);

    var videos = result.docs.map(
      (doc) => VideoModel.fromJson(
        json: doc.data(),
        videoId: doc.id,
      ),
    );

    return videos.toList();
  }

  @override
  FutureOr<List<VideoModel>> build() async {
    _videosRepository = ref.read(videosRepositoryProvider);

    _videos = await _fetchVideos(lastItemCreatedAt: null);

    return _videos;
  }

  Future<void> fetchNextPage() async {
    final nextPage = await _fetchVideos(
      lastItemCreatedAt: _videos.last.createdAt,
    );

    state = AsyncValue.data([..._videos, ...nextPage]);
  }

  Future<void> refresh() async {
    final videos = await _fetchVideos(lastItemCreatedAt: null);
    _videos = videos;
    state = AsyncValue.data(videos);
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
