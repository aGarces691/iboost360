import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';

class ImagePreviewScreen extends StatefulWidget {
  final String imagePath;
  final List<ImageProvider> imageList;

  const ImagePreviewScreen(
      {super.key, required this.imagePath, required this.imageList});

  @override
  State<StatefulWidget> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  late String imagePath;
  late List<ImageProvider> imageList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageList = widget.imageList;
    imagePath = widget.imagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Preview'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: 400,
          height: 400,
          child: Column(children: [
            ImageView360(
              key: UniqueKey(),
              imageList: imageList,
              autoRotate: true, //Optional
              rotationCount: 2, //Optional
              rotationDirection: RotationDirection.anticlockwise, //Optional
              frameChangeDuration: Duration(milliseconds: 50), //Optional
              swipeSensitivity: 2, //Optional
              allowSwipeToRotate: true, //Optional
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Visibility(
                  child: ElevatedButton(
                    onPressed: () {
                      // Coloca aquí el código que se ejecutará cuando se presione el botón 1.
                    },
                    child: Text('Try again'),
                  ), // Usar la función para construir el botón 1
                ),
                Visibility(
                    child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Add'),
                ) // Usar la función para construir el botón 2
                    ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
