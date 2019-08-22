import 'package:cars_dealer/models/car/car.dart';
import 'package:flutter/material.dart';

import 'cars-widgets.dart';

class Cars extends StatefulWidget {
  List<Car> cars = new List<Car>();
  Cars() {
    cars = [];
  }

  @override
  _CarsState createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  @override
  Widget build(BuildContext context) {
    return carsContent(widget.cars, context);
  }
}
