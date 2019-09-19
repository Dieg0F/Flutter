import 'package:flutter/material.dart';

AppBar appBarDefault(String appBarTitle) {
  return AppBar(
    title: Text(
      appBarTitle,
      style: TextStyle(
        color: Colors.white60,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.white60,
    ),
    backgroundColor: Colors.black,
  );
}