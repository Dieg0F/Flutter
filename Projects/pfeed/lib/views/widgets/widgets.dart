import 'package:flutter/material.dart';

AppBar appBar(String title, {List<Widget> actions}) {
  return AppBar(
    title: Text(title),
    actions: actions,
    backgroundColor: Colors.deepPurple,
  );
}

Container basicButton(String textButton, {Function action}) {
  return Container(
    margin: new EdgeInsets.all(50),
    child: MaterialButton(
      child: basicButtonText(textButton),
      color: Colors.deepPurple,
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
