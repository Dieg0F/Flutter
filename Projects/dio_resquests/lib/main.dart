import 'package:dio_resquests/model/user/user.dart';
import 'package:dio_resquests/view/user-widget.dart';
import 'package:flutter/material.dart';

import 'model/user/user-bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        splashColor: Colors.green,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  var items = new List<User>();

  Home() {
    items = [];
  }

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: UserWidget(),
      decoration: BoxDecoration(
        gradient: SweepGradient(
          center: FractionalOffset.topLeft,
          startAngle: 0.0,
          endAngle: 2,
          colors: const <Color>[
            Color(0xFF1db4f5),
            Color(0xFF1dcaf5),
            Color(0xFF00E5FF),
          ],
          stops: const <double>[0.0, 0.5, 0.8],
        ),
      ),
    );
  }
}
