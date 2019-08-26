import 'package:flutter/material.dart';
import 'package:sqflite_test/routes/routes.dart';
import 'package:sqflite_test/view/widgets/widgets.dart' as widget;

class Breeds extends StatefulWidget {
  Breeds({Key key}) : super(key: key);

  _BreedsState createState() => _BreedsState();
}

class _BreedsState extends State<Breeds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar("Breeds"),
      body: Column(
        children: <Widget>[
          widget.basicButton(
            "To Details",
            action: () {
              Routes(context: context).toBreedDetails();
            },
          ),
          widget.basicButton(
            "AddBreed",
            action: () {
              Routes(context: context).toAddBreed();
            },
          ),
        ],
      ),
    );
  }
}
