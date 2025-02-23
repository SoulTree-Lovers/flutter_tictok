import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tictok_clone/features/videos/viewmodels/timeline_view_model.dart';
import 'package:tictok_clone/features/videos/views/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  final PageController _pageController = PageController();
  final _scrollDuration = Duration(milliseconds: 200);
  final _scrollCurve = Curves.linear;

  int _itemCount = 0;

  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    print('Current Page: $page');
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
    if (page == _itemCount - 1) {
      ref.watch(timelineProvider.notifier).fetchNextPage();
     }
  }

  Future<void> _onRefresh() {
    return Future.delayed(
      Duration(seconds: 3),
    );
  }

  void _onVideoFinished() {
    return;
    _pageController.nextPage(
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
          loading: () => Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
          error: (error, stack) => Center(
            child: Text(
              'Error: $error',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          data: (videos) {
            _itemCount = videos.length;

            return RefreshIndicator(
            edgeOffset: 20,
            displacement: 60,
            color: Theme.of(context).primaryColor,
            strokeWidth: 4,
            onRefresh: _onRefresh,
            child: PageView.builder(
              controller: _pageController,
              itemCount: videos.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (BuildContext context, int index) {
                final videoData = videos[index];

                return VideoPost(
                onVideoFinished: _onVideoFinished,
                index: index,
                videoData: videoData,
              );
              },
              pageSnapping: true,
              scrollDirection: Axis.vertical,
            ),
          );
          },
        );
  }
}
