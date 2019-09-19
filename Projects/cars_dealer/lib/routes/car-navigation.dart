import 'package:cars_dealer/models/car/car.dart';
import 'package:cars_dealer/views/details/details.dart';
import 'package:flutter/material.dart';

void navigateToDetail(Car carToDetail, BuildContext context) {
  print(carToDetail.vehicle.name);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Details(car: carToDetail),
    ),
  );
}
