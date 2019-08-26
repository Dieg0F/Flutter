import 'package:flutter/material.dart';
import 'package:pfeed/routes/routes.dart';
import 'package:pfeed/views/widgets/widgets.dart';

Container mainContainer(BuildContext context) {
  return Container(
    child: Center(
      child: content(context),
    ),
    color: Colors.white,
  );
}

Column content(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      basicText("Bem Vindo", 20, Colors.black),
      basicButton("LOGIN", action: () {
        Routes(context: context).toProfiles();
      }),
      basicText("with flutter", 10, Colors.black26),
    ],
  );
}
