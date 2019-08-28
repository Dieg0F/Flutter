import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite_test/model/breed/breed.dart';
import 'package:sqflite_test/view/widgets/widgets.dart';

import 'add-breed-block.dart';

class AddBreedWidgets {
  BuildContext context;
  Breed newBreed = new Breed();

  File breedImage;

  FocusNode nameFocus = new FocusNode();
  FocusNode weigthFocus = new FocusNode();
  FocusNode sizeFocus = new FocusNode();
  FocusNode aboutFocus = new FocusNode();

  void setContext(BuildContext ctx) {
    this.context = ctx;
  }

  Container body() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //basicText("Add a new breed!", 22, Colors.black45),
          //spaceHorizontal(24),
          inputRow("Name: ", inputName()),
          //spaceHorizontal(8),
          inputRow("Weight: ", inputWeight()),
          //spaceHorizontal(8),
          inputRow("Size: ", inputSize()),
          //spaceHorizontal(8),
          inputColumn("About: ", inputAbout()),
          //spaceHorizontal(16),
          inputPicture()
        ],
      ),
    );
  }

  Container inputRow(String label, TextField textField) {
    return Container(
      child: Row(
        children: <Widget>[
          //basicText(label, 20, Colors.black45),
          Container(
            child: textField,
            height: 150,
          ),
        ],
      ),
      height: 150,
    );
  }

  Container inputColumn(String label, TextField textField) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //basicText(label, 20, Colors.black45),
          Container(
            child: textField,
            height: 150,
          ),
        ],
      ),
      height: 250,
    );
  }

  TextField inputName() {
    return TextField(
      onChanged: (String value) {
        newBreed.name = value;
      },
      keyboardType: TextInputType.text,
      cursorColor: Colors.redAccent,
      style: inputTextStyle(),
      decoration: inputDecoration(),
      onSubmitted: (String value) {
        FocusScope.of(context).requestFocus(weigthFocus);
      },
      autofocus: true,
    );
  }

  TextField inputSize() {
    return TextField(
      onChanged: (String value) {
        newBreed.size = int.parse(value);
      },
      keyboardType: TextInputType.number,
      cursorColor: Colors.redAccent,
      style: inputTextStyle(),
      decoration: inputDecoration(),
      onSubmitted: (String value) {
        FocusScope.of(context).requestFocus(aboutFocus);
      },
      focusNode: sizeFocus,
    );
  }

  TextField inputWeight() {
    return TextField(
      onChanged: (String value) {
        newBreed.weight = int.parse(value);
      },
      keyboardType: TextInputType.number,
      cursorColor: Colors.redAccent,
      style: inputTextStyle(),
      decoration: inputDecoration(),
      onSubmitted: (String value) {
        FocusScope.of(context).requestFocus(sizeFocus);
      },
      focusNode: weigthFocus,
    );
  }

  TextField inputAbout() {
    return TextField(
      onChanged: (String value) {
        newBreed.about = value;
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
              newBreed.picture = snapshot.data;
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
