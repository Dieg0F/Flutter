import 'package:dio_resquests/model/user/user.dart';
import 'package:flutter/material.dart';

CircleAvatar userAvatar(User user) {
  return CircleAvatar(
    radius: 70,
    backgroundColor: Colors.white60,
    child: CircleAvatar(
      radius: 65,
      backgroundImage: NetworkImage(user.picture.large),
      backgroundColor: Colors.white,
    ),
  );
}

Container text(String value, double fontSize, Color color) {
  return Container(
    child: Text(
      value,
      textAlign: TextAlign.center,
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
        height: 60.0,
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 4),
            ),
            SizedBox(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                strokeWidth: 2,
              ),
              width: 30.0,
              height: 30.0,
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
          boxShadow: [
            new BoxShadow(
              color: Colors.black54,
              offset: new Offset(0.0, 1.5),
              blurRadius: 1.5,
            )
          ],
          shape: BoxShape.rectangle,
        ),
      ),
    ),
  );
}

Container error(String error) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 280,
          height: 280,
          child: Center(
            child: text(error, 35, Colors.white60),
          ),
        )
      ],
    ),
  );
}
