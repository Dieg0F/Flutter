import 'package:flutter/material.dart';
import 'package:sqflite_test/model/breed/breed.dart';
import 'package:sqflite_test/view/add-breed/add-breed.dart';
import 'package:sqflite_test/view/breeds-details/breed-details.dart';

class Routes {
  BuildContext context;

  Routes({@required this.context});

  void toBreedDetails(Breed breed) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BreedDetails(breed: breed),
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
