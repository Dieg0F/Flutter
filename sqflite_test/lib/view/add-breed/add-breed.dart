import 'package:flutter/material.dart';
import 'package:sqflite_test/view/add-breed/add-breed-widgets.dart';
import 'package:sqflite_test/view/widgets/widgets.dart' as widgets;

class AddBreed extends StatefulWidget {
  _AddBreedState createState() => _AddBreedState();
}

class _AddBreedState extends State<AddBreed> {
  AddBreedWidgets addBreedWidgets = new AddBreedWidgets();

  @override
  Widget build(BuildContext context) {
    addBreedWidgets.setContext(context);

    return Scaffold(
      appBar: widgets.appBar("Add Breed"),
      body: addBreedWidgets.body(),
      floatingActionButton:
          widgets.floatingActionButton(Icons.add, action: saveBreed),
    );
  }

  void saveBreed() {
    if (addBreedWidgets.newBreed != null) {
      addBreedWidgets.newBreed.registered = DateTime.now().toString();

      setState(() {
        print("Id: " + addBreedWidgets.newBreed.id.toString());
        print("Name: " + addBreedWidgets.newBreed.name.toString());
        print("Registred: " + addBreedWidgets.newBreed.registered.toString());
        print("Size: " + addBreedWidgets.newBreed.size.toString());
        print("Weight: " + addBreedWidgets.newBreed.weight.toString());
        print("About: " + addBreedWidgets.newBreed.about.toString());
      });
    }
  }
}
