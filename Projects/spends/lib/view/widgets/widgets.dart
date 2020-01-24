import 'package:flutter/material.dart';
import 'package:spends/utils/categories/categories.dart';

AppBar appBar(String title, {List<Widget> actions}) {
  return AppBar(
    title: Text(title),
    actions: actions,
    backgroundColor: Colors.teal[400],
  );
}

Container basicButton(String textButton, {Function action}) {
  return Container(
    margin: new EdgeInsets.all(50),
    child: MaterialButton(
      child: basicButtonText(textButton),
      color: Colors.teal,
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
    textAlign: TextAlign.center,
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
    backgroundColor: Colors.teal[500],
  );
}

DropdownButton<String> categoryDropDown(
    String hintText, Function action, String value) {
  return DropdownButton<String>(
    value: value,
    isExpanded: true,
    underline: Container(),
    hint: Container(
      child: basicText(hintText, 28, Colors.black26),
    ),
    icon: Icon(
      Icons.keyboard_arrow_down,
      color: Colors.black45,
      size: 30,
    ),
    onChanged: (String newValue) {
      action(newValue);
    },
    items: getAllCategories().map<DropdownMenuItem<String>>((String value) {
      return dropdownMenuItem(value);
    }).toList(),
  );
}

DropdownMenuItem<String> dropdownMenuItem(String value) {
  return DropdownMenuItem<String>(
      value: value,
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              child: Image.asset(getIconByCategory(value)),
              padding: EdgeInsets.only(top: 4, right: 8, bottom: 4),
            ),
            Container(
              child: basicText(value, 26, Colors.black54),
              padding: EdgeInsets.only(top: 4, right: 8, bottom: 4),
            ),
          ],
        ),
      ),
    );
}
