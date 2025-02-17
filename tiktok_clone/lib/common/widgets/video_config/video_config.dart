import 'package:flutter/cupertino.dart';

class VideoConfig extends ChangeNotifier {
  bool autoMuted = true;

  void toggleAutoMute() {
    autoMuted = !autoMuted;
    notifyListeners();
  }
}

final videoConfig = VideoConfig();