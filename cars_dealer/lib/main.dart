import 'package:flutter/material.dart';

import 'widget/cars/cars.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cars Dealer',
      debugShowCheckedModeBanner: false,
      home: Cars(),
    );
  }
}
