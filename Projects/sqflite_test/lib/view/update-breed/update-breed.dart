import 'package:flutter/material.dart';
import 'package:sqflite_test/model/breed/breed-dao.dart';
import 'package:sqflite_test/model/breed/breed.dart';
import 'package:sqflite_test/view/update-breed/update-breed-bloc.dart';
import 'package:sqflite_test/view/update-breed/update-breed-widgets.dart';
import 'package:sqflite_test/view/widgets/widgets.dart' as widgets;

class UpdateBreed extends StatefulWidget {
  Breed breed;
  UpdateBreed({Key key, @required this.breed}) : super(key: key);

  _UpdateBreedState createState() => _UpdateBreedState();
}

class _UpdateBreedState extends State<UpdateBreed> {
  UpdateBreedWidgets updateBreedWidgets;
  BreedDao breedDao;

  _UpdateBreedState() {
    breedDao = new BreedDao();
    updateBreedWidgets = new UpdateBreedWidgets(breedToUpdate: widget.breed);
  }

  @override
  Widget build(BuildContext context) {
    updateBreedWidgets.setContext(context);
    return Scaffold(
      appBar: widgets.appBar("Add Breed"),
      body: StreamBuilder<Breed>(
        builder: (BuildContext context, AsyncSnapshot<Breed> snapshot) {
          if (snapshot.data == null) {
            if (!snapshot.hasError) {
              return SingleChildScrollView(
                child: updateBreedWidgets.body(),
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
    if (updateBreedWidgets.breedToUpdate != null) {
      setState(() {
        bloc.updateBreed(updateBreedWidgets.breedToUpdate);
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
