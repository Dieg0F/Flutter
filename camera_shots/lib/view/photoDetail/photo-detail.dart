import 'dart:io';
import 'package:camera_shots/view/photoDetail/widgets.dart';
import 'package:flutter/material.dart';

class PhotoDetail extends StatefulWidget {
  final File file;

  PhotoDetail({Key key, @required this.file}) : super(key: key);

  _PhotoDetailState createState() => _PhotoDetailState();
}

class _PhotoDetailState extends State<PhotoDetail> {
  @override
  Widget build(BuildContext context) {
    return photoDetailPage(widget.file);
  }
}
