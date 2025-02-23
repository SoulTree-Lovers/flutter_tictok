import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/videos/models/video_model.dart';
import 'package:tictok_clone/features/videos/viewmodels/playback_config_vm.dart';
import 'package:tictok_clone/features/videos/views/widgets/video_button.dart';
import 'package:tictok_clone/features/videos/views/widgets/video_comments.dart';
import 'package:tictok_clone/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final int index;
  final VideoModel videoData;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
    required this.videoData,
  });

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _controller = VideoPlayerController.asset(
    'assets/videos/video.mp4',
  );

  bool _isPaused = false;

  // bool _autoMuted = videoConfig.value;

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

    if (kIsWeb) {
      await _controller.setVolume(0);
    }

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

  void _onPlaybackConfigChanged() {
    if (!mounted) return;
    if (false) {
      _controller.setVolume(0);
    } else {
      _controller.setVolume(1);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo visibilityInfo) {
    if (!mounted) {
      return;
    }

    print(
        "Video: ${widget.index} is ${visibilityInfo.visibleFraction * 100}% visible");
    if (visibilityInfo.visibleFraction == 1 &&
        !_controller.value.isPlaying &&
        !_isPaused) {
      if (ref.read(playbackConfigProvider).autoPlay) {
        _controller.play();
      }
    }

    if (_controller.value.isPlaying && visibilityInfo.visibleFraction == 0) {
      _onTogglePause();
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
                : Image.network(
                    widget.videoData.thumbnailUrl,
                    fit: BoxFit.cover,
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
            top: Sizes.size52,
            left: Sizes.size32,
            child: IconButton(
              onPressed: _onPlaybackConfigChanged,
              icon: FaIcon(
                ref.watch(playbackConfigProvider).muted
                    ? FontAwesomeIcons.volumeXmark
                    : FontAwesomeIcons.volumeHigh,
                color: Colors.black38,
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
                  "@${widget.videoData.creatorName}",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v16,
                FractionallySizedBox(
                  child: Text(
                    "${widget.videoData.description}",
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
                      "https://firebasestorage.googleapis.com/v0/b/tiktok-202502.firebasestorage.app/o/avatars%2${widget.videoData.creatorUid}?alt=media&token=eb79b397-ae54-4f9a-b8e9-9e3e7612155e"),
                  child: Text("${widget.videoData.creatorName}"),
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: S.of(context).likeCount(widget.videoData.likes),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: S.of(context).commentCount(widget.videoData.comments),
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
