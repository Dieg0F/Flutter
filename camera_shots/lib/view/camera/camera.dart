import 'dart:io';

import 'package:camera_shots/view/camera/widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  Camera({Key key}) : super(key: key);

  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  List<File> files = new List<File>();

  _CameraState() {
    files = [];
  }

  Future getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);

    if (image != null) {
      setState(() {
        files.add(image);
        print(image);
      });
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
      ),
      body: Center(
        child: files.length == 0 ? emptyList() : photoGrid(files, context),
      ),
      floatingActionButton: addPhoto(getImage, context),
    );
  }
}
