import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';

File _image;
String _imageSize = "";

Scaffold photoDetailPage(File image) {
  _image = image;
  getImageSize();

  return Scaffold(
    appBar: AppBar(
      elevation: 5,
      title: Text("Image Detail"),
    ),
    body: photoDetailPageBody(),
  );
}

Future<String> getImageSize() async {
  var imageLenght = await _image.length();
  var imageLentStringSize = imageLenght.toString().length;

  var imageSize = (imageLenght / pow(10, (imageLentStringSize - 1)));

  _imageSize = imageSize.toString() + " Bytes";

  return _imageSize;
}

Container photoDetailPageBody() {
  return Container(child: imageData());
}

Container imageData() {
  return Container(
    child: Column(
      children: <Widget>[
        imageDataDescription(),
        Image.file(_image),
      ],
    ),
  );
}

Container imageDataDescription() {
  return Container(
      child: Column(
        children: <Widget>[
          imageDataDescriptionRow("Image Location:", _image.path),
          imageDataDescriptionRow("Image Size:", _imageSize),
        ],
      ),
      padding: EdgeInsets.all(16));
}

Container imageDataDescriptionRow(String label, String message) {
  return Container(
    child: Column(
      children: <Widget>[
        imageDataLabel(label),
        imageDataText(message),
      ],
    ),
  );
}

Container imageDataLabel(String label) {
  return Container(
    child: Text(
      label,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.black45,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    ),
  );
}

Container imageDataText(String message) {
  return Container(
    child: Text(
      message,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.black45,
        fontSize: 18,
      ),
    ),
    padding: EdgeInsets.only(
      bottom: 16,
    ),
  );
}
