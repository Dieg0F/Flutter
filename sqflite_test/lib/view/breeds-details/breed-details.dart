import 'package:flutter/material.dart';
import 'package:sqflite_test/view/widgets/widgets.dart' as widgets;

class BreedDetails extends StatefulWidget {
  BreedDetails({Key key}) : super(key: key);

  _BreedDetailsState createState() => _BreedDetailsState();
}

class _BreedDetailsState extends State<BreedDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widgets.appBar("Breed Details"),
      body: Center(
        child: Text("Breed Details"),
      ),
    );
  }
}
