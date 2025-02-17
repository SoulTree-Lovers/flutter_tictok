import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatefulWidget {
  final File video;
  final bool isPicked;

  const VideoPreviewScreen({
    super.key,
    required this.video, required this.isPicked,
  });

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;

  bool _savedVideo = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initVideo();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<void> _initVideo() async {
    _videoPlayerController = VideoPlayerController.file(
      widget.video,
    );

    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();

    setState(() {});
  }

  Future<void> _saveToGallery() async {
    if (_savedVideo) {
      return;
    }

    await GallerySaver.saveVideo(
      widget.video.path,
      albumName: 'TicTok Clone',
    );

    _savedVideo = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Video Preview'),
        actions: [
          if (!widget.isPicked)
          IconButton(
            onPressed: _saveToGallery,
            icon: FaIcon(
              _savedVideo ? FontAwesomeIcons.check : FontAwesomeIcons.download,
            ),
          ),
        ],
      ),
      body: _videoPlayerController.value.isInitialized
          ? VideoPlayer(_videoPlayerController)
          : null,
    );
  }
}
