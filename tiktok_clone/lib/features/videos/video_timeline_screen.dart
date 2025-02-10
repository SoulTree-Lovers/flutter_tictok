import 'package:flutter/material.dart';
import 'package:tictok_clone/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  final PageController _pageController = PageController();
  final _scrollDuration = Duration(milliseconds: 200);
  final _scrollCurve = Curves.linear;

  int _itemCount = 5;

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
      setState(() {
        /*_itemCount += 5;
        colors.addAll([
          Colors.red,
          Colors.blue,
          Colors.green,
          Colors.yellow,
          Colors.purple,
        ]);*/
        print('Item Count: $_itemCount');
      });
    }
  }

  void _onVideoFinished() {
    _pageController.nextPage(
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: _itemCount,
      onPageChanged: _onPageChanged,
      itemBuilder: (BuildContext context, int index) => VideoPost(
        onVideoFinished: _onVideoFinished,
        index: index,
      ),
      pageSnapping: true,
      scrollDirection: Axis.vertical,
    );
  }
}
