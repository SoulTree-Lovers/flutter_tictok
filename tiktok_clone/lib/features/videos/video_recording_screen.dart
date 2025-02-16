import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tictok_clone/constants/gaps.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  bool _hasPermission = true;
  late final CameraController _cameraController;

  Future<void> initCamera() async {
    // 카메라 초기화
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      cameras.first,
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();
  }

  Future<void> initPermissions() async {
    var cameraPermission = await Permission.camera.request();
    var micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied || !micDenied) {
      // 카메라, 마이크 권한이 허용되어 있으면
      _hasPermission = true;
      await initCamera();
      setState(() {});
    } else {
      // 권한 설정 페이지로 이동
      openAppSettings();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: double.infinity,
        child: !_hasPermission || !_cameraController.value.isInitialized
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Initializing...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Gaps.v20,
                  CircularProgressIndicator.adaptive(),
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  CameraPreview(_cameraController),
                ],
              ),
      ),
    );
  }
}
