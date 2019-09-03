import 'package:flutter/material.dart';

AppBar appBar(String title, {List<Widget> actions}) {
  return AppBar(
    title: Text(title),
    actions: actions,
    backgroundColor: Colors.red,
  );
}

Container basicButton(String textButton, {Function action}) {
  return Container(
    margin: new EdgeInsets.all(50),
    child: MaterialButton(
      child: basicButtonText(textButton),
      color: Colors.red,
      onPressed: () {
        action();
      },
    ),
  );
}

Text basicButtonText(String value) {
  return Text(
    value,
    style: TextStyle(
      color: Colors.white,
    ),
  );
}

Text basicText(String value, double fSize, Color c) {
  return Text(
    value,
    style: TextStyle(
      fontFamily: 'Roboto',
      fontSize: fSize,
      color: c,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w300,
    ),
  );
}

Text lightText(String value, double fSize, Color c) {
  return Text(
    value,
    style: TextStyle(
      fontFamily: 'Roboto',
      fontSize: fSize,
      color: c,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.w100,
    ),
  );
}

TextStyle inputTextStyle() {
  return TextStyle(
    color: Colors.black38,
    fontSize: 26,
    letterSpacing: 0.5,
    fontWeight: FontWeight.w300,
  );
}

InputDecoration inputDecoration() {
  return InputDecoration(
    border: InputBorder.none,
    hintStyle: TextStyle(
      color: Colors.black38,
    ),
  );
}

Padding spaceHorizontal(double size) {
  return Padding(
    padding: new EdgeInsets.only(
      top: size,
    ),
  );
}

Padding spaceVertical(double size) {
  return Padding(
    padding: new EdgeInsets.only(
      left: size,
    ),
  );
}

FloatingActionButton floatingActionButton(IconData icon, {Function action}) {
  return FloatingActionButton(
    onPressed: action,
    child: Icon(
      icon,
      color: Colors.white70,
    ),
  );
}
