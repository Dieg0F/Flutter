import 'package:dio_resquests/model/user/user.dart';
import 'package:flutter/material.dart';

CircleAvatar userAvatar(User user) {
  return CircleAvatar(
    radius: 70,
    backgroundColor: Colors.white60,
    child: CircleAvatar(
      radius: 65,
      backgroundImage: NetworkImage(user.picture.large),
    ),
  );
}

Container text(String value, double fontSize, Color color) {
  return Container(
    child: Text(
      value,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        letterSpacing: 1,
        decoration: TextDecoration.none,
        color: color,
      ),
    ),
  );
}

Container loading(String message) {
  return Container(
    child: Center(
      child: Container(
        width: 260.0,
        height: 82.0,
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 2,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
            ),
            text(message, 10, Colors.black54),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          shape: BoxShape.rectangle,
        ),
      ),
    ),
  );
}
