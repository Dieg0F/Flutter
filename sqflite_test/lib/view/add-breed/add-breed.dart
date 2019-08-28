import 'package:flutter/material.dart';
import 'package:sqflite_test/model/breed/breed-dao.dart';
import 'package:sqflite_test/model/breed/breed.dart';
import 'package:sqflite_test/view/add-breed/add-breed-widgets.dart';
import 'package:sqflite_test/view/add-breed/add-breed-block.dart';
import 'package:sqflite_test/view/widgets/widgets.dart' as widgets;

class AddBreed extends StatefulWidget {
  _AddBreedState createState() => _AddBreedState();
}

class _AddBreedState extends State<AddBreed> {
  AddBreedWidgets addBreedWidgets;
  BreedDao breedDao;

  _AddBreedState() {
    breedDao = new BreedDao();
    addBreedWidgets = new AddBreedWidgets();
  }

  @override
  Widget build(BuildContext context) {
    addBreedWidgets.setContext(context);
    return Scaffold(
      appBar: widgets.appBar("Add Breed"),
      body: StreamBuilder<Breed>(
        builder: (BuildContext context, AsyncSnapshot<Breed> snapshot) {
          if (snapshot.data == null) {
            if (!snapshot.hasError) {
              return SingleChildScrollView(
                child: addBreedWidgets.body(),
              );
            }
          } else {
            return requestingData();
          }
        },
      ),
      floatingActionButton: widgets.floatingActionButton(Icons.add, action: () {
        saveBreed(context);
      }),
    );
  }

  void saveBreed(BuildContext context) {
    if (addBreedWidgets.newBreed != null) {
      setState(() {
        bloc.insertNewBreed(addBreedWidgets.newBreed);
        Navigator.pop(context);
      });
    }
  }

  Container requestingData() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
