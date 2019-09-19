import 'package:camera_shots/model/picture.dart';
import 'package:camera_shots/view/camera/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'image-options.dart';

class Camera extends StatefulWidget {
  Camera({Key key}) : super(key: key);

  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  List<Picture> pics = new List<Picture>();
  int counter = 0;
  _CameraState() {
    pics = [];
  }

  Future getImage(ImageSource source) async {
    var imageFile = await ImagePicker.pickImage(source: source);

    if (imageFile != null) {
      counter++;
      var pic = await ImageOptions(
        imageFile,
        originalSize: 1024,
      ).toPicture(
        "image_" + counter.toString(),
        imageQuality: 60,
        thumbSize: 400,
      );
      if (pic != null) {
        setState(() {
          pics.add(pic);
          print(pic);
        });
      }
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();

    if (response == null) {
      return;
    }
    if (response.file != null) {
      setState(() {
        print(response.file);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    retrieveLostData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Galery'),
        elevation: 8,
      ),
      body: Center(
        child: pics.length == 0 ? emptyList() : photoGrid(pics, context),
      ),
      floatingActionButton: addPhoto(getImage, context),
    );
  }
}
