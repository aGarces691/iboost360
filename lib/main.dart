import 'package:camera_test/camera_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<CameraDescription> cameras = await availableCameras();
  runApp(CameraApp(cameras));
}

class CameraApp extends StatelessWidget {
  final List<CameraDescription> cameras;

  CameraApp(this.cameras);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraPreviewScreen(cameras),
    );
  }
}
