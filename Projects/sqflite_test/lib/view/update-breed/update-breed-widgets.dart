import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite_test/model/breed/breed.dart';
import 'package:sqflite_test/view/widgets/widgets.dart';

import 'update-breed-bloc.dart';

class UpdateBreedWidgets {
  BuildContext context;
  Breed breedToUpdate;

  File breedImage;

  FocusNode nameFocus = new FocusNode();
  FocusNode weigthFocus = new FocusNode();
  FocusNode sizeFocus = new FocusNode();
  FocusNode aboutFocus = new FocusNode();

  UpdateBreedWidgets({this.breedToUpdate});

  void setContext(BuildContext ctx) {
    this.context = ctx;
  }

  Container body() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          basicText("Add a new breed!", 22, Colors.black45),
          spaceHorizontal(24),
          inputRow("Name: ", inputName()),
          spaceHorizontal(8),
          inputRow("Weight: ", inputWeight()),
          spaceHorizontal(8),
          inputRow("Size: ", inputSize()),
          spaceHorizontal(8),
          inputColumn("About: ", inputAbout()),
          spaceHorizontal(16),
          inputPicture()
        ],
      ),
    );
  }

  Container inputRow(String label, TextFormField textFormField) {
    return Container(
      child: Row(
        children: <Widget>[
          basicText(label, 20, Colors.black45),
          Container(
            child: new Flexible(
              child: textFormField,
            ),
          ),
        ],
      ),
      height: 50,
    );
  }

  Container inputColumn(String label, TextFormField textFormField) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          basicText(label, 20, Colors.black45),
          Container(
            child: new Flexible(
              child: textFormField,
            ),
          ),
        ],
      ),
      height: 200,
    );
  }

  TextFormField inputName() {
    return TextFormField(
      initialValue: breedToUpdate.name,
      keyboardType: TextInputType.text,
      cursorColor: Colors.redAccent,
      style: inputTextStyle(),
      decoration: inputDecoration(),
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(weigthFocus);
      },
      autofocus: true,
    );
  }

  TextFormField inputSize() {
    return TextFormField(
      initialValue: breedToUpdate.size.toString(),
      keyboardType: TextInputType.number,
      cursorColor: Colors.redAccent,
      style: inputTextStyle(),
      decoration: inputDecoration(),
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(aboutFocus);
      },
      focusNode: sizeFocus,
    );
  }

  TextFormField inputWeight() {
    return TextFormField(
      initialValue: breedToUpdate.weight.toString(),
      keyboardType: TextInputType.number,
      cursorColor: Colors.redAccent,
      style: inputTextStyle(),
      decoration: inputDecoration(),
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(sizeFocus);
      },
      focusNode: weigthFocus,
    );
  }

  TextFormField inputAbout() {
    return TextFormField(
      initialValue: breedToUpdate.about,
      onFieldSubmitted: (String value) {
        breedToUpdate.about = value;
      },
      keyboardType: TextInputType.text,
      cursorColor: Colors.redAccent,
      maxLines: 40,
      style: inputTextStyle(),
      decoration: inputDecoration(),
      focusNode: aboutFocus,
    );
  }

  Container inputPicture() {
    return Container(
      child: Center(
        child: StreamBuilder<String>(
          stream: bloc.subjectForImage.stream,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData && snapshot.data != "") {
              breedToUpdate.picture = snapshot.data;
              return showImage(snapshot.data);
            } else {
              return addPicture();
            }
          },
        ),
      ),
      color: Color(0xAEDCDCDC),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
    );
  }

  Container addPicture() {
    return Container(
      child: InkResponse(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.camera,
              color: Colors.black38,
            ),
            spaceHorizontal(8),
            basicText("Add Picture", 20, Colors.black38)
          ],
        ),
        onTap: () {
          _showDialog();
        },
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
    );
  }

  Container showImage(String imagePath) {
    return Container(
      child: InkResponse(
        child: Image.file(
          File(imagePath),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
        ),
        onTap: () {
          _showDialog();
        },
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return getPhotoDialog();
      },
    );
  }

  AlertDialog getPhotoDialog() {
    return AlertDialog(
      title: alertTitle("Adicione uma foto."),
      content: alertBody("Deseja tirar uma foto ou buscar na galeria?"),
      actions: <Widget>[
        getPhotoDialogButton("Câmera", ImageSource.camera),
        getPhotoDialogButton("Galeria", ImageSource.gallery),
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

  FlatButton getPhotoDialogButton(String text, ImageSource source) {
    return FlatButton(
      child: Text(text.toUpperCase()),
      onPressed: () {
        bloc.requestImage(source);
        Navigator.pop(context);
      },
    );
  }
}
