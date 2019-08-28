import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite_test/model/breed/breed.dart';
import 'package:sqflite_test/view/breeds-details/breed-details-widgets.dart';
import 'package:sqflite_test/view/widgets/widgets.dart' as widgets;

class BreedDetails extends StatefulWidget {
  Breed breed;
  BreedDetails({Key key, @required this.breed}) : super(key: key);

  _BreedDetailsState createState() => _BreedDetailsState();
}

class _BreedDetailsState extends State<BreedDetails> {
  BreedDetailsWidgets breedDetailsWidgets;

  @override
  Widget build(BuildContext context) {
    breedDetailsWidgets = new BreedDetailsWidgets(context: context);

    return Scaffold(
      appBar: widgets.appBar(widget.breed.name),
      body: breedDetailsWidgets.body(widget.breed),
    );
  }
}
