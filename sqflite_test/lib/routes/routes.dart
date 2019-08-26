import 'package:flutter/material.dart';
import 'package:sqflite_test/view/add-breed/add-breed.dart';
import 'package:sqflite_test/view/breeds-details/breed-details.dart';

class Routes {
  BuildContext context;

  Routes({@required this.context});

  void toBreedDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BreedDetails(),
      ),
    );
  }  

  void toAddBreed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBreed(),
      ),
    );
  }  
}
