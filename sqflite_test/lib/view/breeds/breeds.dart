import 'package:flutter/material.dart';
import 'package:sqflite_test/routes/routes.dart';
import 'package:sqflite_test/view/widgets/widgets.dart' as widgets;

import 'breeds-block.dart';
import 'breeds-widgets..dart';

class Breeds extends StatefulWidget {
  Breeds() {
    bloc.getAllBreeds();
  }

  _BreedsState createState() => _BreedsState();
}

class _BreedsState extends State<Breeds> {
  @override
  Widget build(BuildContext context) {
    bloc.getAllBreeds();
    return Scaffold(
      appBar: widgets.appBar("Breeds"),
      body: BreedsWidgets(context: context).mainContent(),
      floatingActionButton: floatingButton(),
    );
  }

  void toAddBreed() {
    Routes(context: context).toAddBreed();
  }

  void removeBreed() {
    bloc.removeBreeds();
  }

  StreamBuilder floatingButton() {
    return StreamBuilder<bool>(
      stream: bloc.subjectForEnableMultiSelect.stream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == true) {
          return widgets.floatingActionButton(Icons.clear, action: removeBreed);
        } else {
          return widgets.floatingActionButton(Icons.add, action: toAddBreed);
        }
      },
    );
  }
}
