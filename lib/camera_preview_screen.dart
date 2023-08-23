import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_test/image_preview.dart';
import 'package:flutter/material.dart';

class CameraPreviewScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  CameraPreviewScreen(this.cameras);

  @override
  _CameraPreviewScreenState createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late XFile imageSelected;
  List<ImageProvider> imageList = [];
  int imageQuantity = 20;

  @override
  void initState() {
    super.initState();
    final firstCamera = widget.cameras.first;
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Preview App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            Text('${imageList.length} / ${imageQuantity}')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _takePicture();
          goToNextScreen();
        },
        tooltip: 'Take Picture',
        child: Icon(Icons.camera),
      ),
    );
  }

  Future<void> _takePicture() async {
    try {
      // Make sure the camera controller is initialized
      await _initializeControllerFuture;

      // Capture the image
      final xFile = await _controller.takePicture();
      imageSelected = xFile;
      setState(() {});
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  void goToNextScreen() {
    ImageProvider fileImage = FileImage(File(imageSelected.path));
    imageList.add(fileImage);
    if (imageList.length == imageQuantity) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePreviewScreen(
            imagePath: imageSelected.path,
            imageList: imageList,
          ),
        ),
      );
    }
  }
}
