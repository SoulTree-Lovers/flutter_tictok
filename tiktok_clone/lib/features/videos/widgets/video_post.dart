import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/videos/widgets/video_button.dart';
import 'package:tictok_clone/features/videos/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _controller = VideoPlayerController.asset(
    'assets/videos/video2.mp4',
  );

  bool _isPaused = false;
  final Duration _animationDuration = Duration(milliseconds: 300);
  late final AnimationController _animationController;

  void _onVideoChanged() {
    if (_controller.value.isInitialized) {
      if (_controller.value.duration == _controller.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    await _controller.initialize();

    _controller.setLooping(true); // 무한 반복
    _controller.addListener(_onVideoChanged);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
      reverseDuration: _animationDuration,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo visibilityInfo) {
    print(
        "Video: ${widget.index} is ${visibilityInfo.visibleFraction * 100}% visible");
    if (visibilityInfo.visibleFraction == 1 &&
        !_controller.value.isPlaying &&
        !_isPaused) {
      _controller.play();
    }
  }

  void _onTogglePause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      _animationController.reverse();
    } else {
      _controller.play();
      _animationController.forward();
    }

    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onCommentsTap(BuildContext context) async {
    if (_controller.value.isPlaying) {
      _onTogglePause();
    }

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => VideoComments(),
    );

    _onTogglePause();
    print("closed");
  }

  @override
  Widget build(BuildContext context) {
    print("build"); // 빌드 호출 확인

    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _controller.value.isInitialized
                ? VideoPlayer(_controller)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child,
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1.0 : 0.0,
                    duration: _animationDuration,
                    child: FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size48,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: Sizes.size32,
            left: Sizes.size32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@username",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v16,
                FractionallySizedBox(
                  child: Text(
                    "Description",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Gaps.v16,
              ],
            ),
          ),
          Positioned(
            bottom: Sizes.size32,
            right: Sizes.size32,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  foregroundImage: NetworkImage(
                      "https://avatars.githubusercontent.com/u/54972879?v=4"),
                  child: Text("니꼬"),
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: "2.9M",
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: "33K",
                  ),
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                ),
                Gaps.v10,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
