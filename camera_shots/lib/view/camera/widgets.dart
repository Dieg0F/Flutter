import 'dart:io';

import 'package:camera_shots/model/picture.dart';
import 'package:camera_shots/view/photoDetail/photo-detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:image_picker/image_picker.dart';

GridView photoGrid(List<Picture> pics, BuildContext context) {
  return GridView.count(
    crossAxisCount: 4,
    cacheExtent: double.infinity,
    children: List.generate(
      pics.length,
      (index) {
        return InkResponse(
          onTap: () {
            onItemTap(context, pics[index].originalFile);
          },
          onLongPress: () {
            onItemTap(context, pics[index].originalFile);
          },
          child: Padding(
            padding: new EdgeInsets.all(0.5),
            child: photoItem(pics[index].thumbnail),
          ),
        );
      },
    ),
  );
}

Container emptyList() {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        emptyListIcon(),
        emptyListText("Galeria Vazia!"),
        emptyListText("Clique no botão no canto da tela para tirar fotos."),
      ],
    ),
  );
}

Container emptyListText(String message) {
  return Container(
    child: Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 25,
        color: Colors.black38,
      ),
    ),
    margin: EdgeInsets.all(8.0),
  );
}

Container emptyListIcon() {
  return Container(
    child: Icon(
      Icons.add_photo_alternate,
      color: Colors.black38,
      size: 80,
    ),
    margin: EdgeInsets.only(
      bottom: 20.0,
    ),
  );
}

Container photoItem(File file) {
  print(file.path);
  return Container(
    child: Image.file(
      file,
      height: 200.0,
      width: 200.0,
    ),
  );
}

FloatingActionButton addPhoto(Function function, BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      _showDialog(function, context);
    },
    tooltip: 'Pick Image',
    child: Icon(Icons.camera_alt),
  );
}

void _showDialog(Function function, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return getPhotoDialog(function, context);
    },
  );
}

AlertDialog getPhotoDialog(Function function, BuildContext context) {
  return AlertDialog(
    title: alertTitle("Adicione uma foto."),
    content: alertBody("Deseja tirar uma foto ou buscar na galeria?"),
    actions: <Widget>[
      getPhotoDialogButton("Câmera", function, ImageSource.camera, context),
      getPhotoDialogButton("Galeria", function, ImageSource.gallery, context),
    ],
    elevation: 5.0,
  );
}

Container alertTitle(String message) {
  return Container(
    child: Text(
      message,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 18,
        color: Colors.black38,
      ),
    ),
    margin: EdgeInsets.only(top: 0.0, bottom: 8.0, left: 0.0),
  );
}

Container alertBody(String message) {
  return Container(
    child: Text(
      message,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black38,
      ),
    ),
  );
}

FlatButton getPhotoDialogButton(
    String text, Function function, ImageSource source, BuildContext context) {
  return FlatButton(
    child: Text(text.toUpperCase()),
    onPressed: () {
      function(source);
      Navigator.pop(context);
    },
  );
}

void onItemTap(BuildContext context, File image) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PhotoDetail(file: image),
    ),
  );
}
