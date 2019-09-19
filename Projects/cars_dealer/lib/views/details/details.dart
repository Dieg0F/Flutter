import 'package:cars_dealer/models/car/car.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../cummon-widgets.dart';

class Details extends StatefulWidget {
  final Car car;
  Details({Key key, @required this.car}) : super(key: key);

  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String appBarTitle = "";
  var carDetail;

  _DetailsState() {
    carDetail = widget.car;
    appBarTitle = carDetail.brand.name + " " + carDetail.vehicle.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(appBarTitle),
      body: Container(),
      backgroundColor: Colors.black,
    );
  }
}
