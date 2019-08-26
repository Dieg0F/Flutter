import 'package:flutter/material.dart';
import 'package:sqflite_test/model/breed/breed.dart';
import 'package:sqflite_test/view/widgets/widgets.dart';

class AddBreedWidgets {
  BuildContext context;
  Breed newBreed = new Breed();

  FocusNode nameFocus = new FocusNode();
  FocusNode weigthFocus = new FocusNode();
  FocusNode sizeFocus = new FocusNode();
  FocusNode aboutFocus = new FocusNode();

  void setContext(BuildContext ctx) {
    this.context = ctx;
  }

  Container body() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          basicText("Add a new breed!", 22, Colors.black45),
          spaceHorizontal(24),
          inputRow("Name: ", inputName()),
          spaceHorizontal(8),
          inputRow("Weight: ", inputWeight()),
          spaceHorizontal(8),
          inputRow("Size: ", inputSize()),
          spaceHorizontal(8),
          inputRow("About: ", inputAbout()),
        ],
      ),
      padding: new EdgeInsets.all(32),
    );
  }

  Flexible inputRow(String label, TextField textField) {
    return Flexible(
      child: Row(
        children: <Widget>[
          basicText(label, 20, Colors.black45),
          new Flexible(
            child: textField,
          ),
        ],
      ),
    );
  }

  TextField inputName() {
    return TextField(
      onChanged: (String value) {
        newBreed.name = value;
      },
      keyboardType: TextInputType.text,
      cursorColor: Colors.redAccent,
      style: inputTextStyle(),
      decoration: inputDecoration(),
      onSubmitted: (String value) {
        print("onSubmitted: " + value);
        FocusScope.of(context).requestFocus(weigthFocus);
      },
      autofocus: true,
    );
  }

  TextField inputSize() {
    return TextField(
      onChanged: (String value) {
        newBreed.size = int.parse(value);
      },
      keyboardType: TextInputType.text,
      cursorColor: Colors.redAccent,
      style: inputTextStyle(),
      decoration: inputDecoration(),
      onSubmitted: (String value) {
        print("onSubmitted: " + value);
        FocusScope.of(context).requestFocus(aboutFocus);
      },
      focusNode: sizeFocus,
    );
  }

  TextField inputWeight() {
    return TextField(
      onChanged: (String value) {
        newBreed.weight = int.parse(value);
      },
      keyboardType: TextInputType.text,
      cursorColor: Colors.redAccent,
      style: inputTextStyle(),
      decoration: inputDecoration(),
      onSubmitted: (String value) {
        print("onSubmitted: " + value);
        FocusScope.of(context).requestFocus(sizeFocus);
      },
      focusNode: weigthFocus,
    );
  }

  TextField inputAbout() {
    return TextField(
      onChanged: (String value) {
        newBreed.about = value;
      },
      keyboardType: TextInputType.text,
      cursorColor: Colors.redAccent,
      //maxLines: 20,
      style: inputTextStyle(),
      decoration: inputDecoration(),
      focusNode: aboutFocus,
    );
  }
}
