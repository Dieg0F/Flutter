import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite_test/model/breed/breed.dart';
import 'package:sqflite_test/view/widgets/widgets.dart';

class BreedDetailsWidgets {
  BuildContext context;

  BreedDetailsWidgets({this.context});

  Container body(Breed breed) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            breedImage(breed.picture),
            breedDescription(breed),
          ],
        ),
      ),
    );
  }

  Container breedImage(String imagePath) {
    if (imagePath == "") {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.camera,
              color: Colors.black38,
            ),
            spaceHorizontal(8),
            basicText("No Picture", 20, Colors.black38)
          ],
        ),
        color: Colors.red,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.3,
      );
    } else {
      return Container(
        child: Image.file(
          File(imagePath),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
        ),
      );
    }
  }

  Container breedDescription(Breed breed) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          descriptionRow("Breed: ", breed.name),
          descriptionRow("Weigth: ", breed.weight.toString()),
          descriptionRow("Size: ", breed.size.toString()),
          descriptionColumn("About: ", breed.about),
        ],
      ),
      padding: new EdgeInsets.all(16),
    );
  }

  Container descriptionRow(String label, String labelValue) {
    return Container(
      child: Row(
        children: <Widget>[
          basicText(label, 26, Colors.black45),
          basicText(labelValue, 24, Colors.black45),
        ],
      ),
      padding: new EdgeInsets.only(bottom: 16),
    );
  }

  Container descriptionColumn(String label, String labelValue) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          basicText(label, 26, Colors.black45),
          spaceHorizontal(4),
          basicText(labelValue, 24, Colors.black45),
        ],
      ),
    );
  }
}
