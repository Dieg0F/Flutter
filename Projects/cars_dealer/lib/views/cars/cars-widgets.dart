import 'package:cars_dealer/models/car/car.dart';
import 'package:cars_dealer/models/dummy.dart';
import 'package:cars_dealer/routes/car-navigation.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../cummon-widgets.dart';

var carList = new List<Car>();
BuildContext context;

Scaffold carsContent(List<Car> cars, BuildContext ctx) {
  context = ctx;
  carList = cars;
  carList.add(getCar());
  carList.add(getCar());
  carList.add(getCar());
  carList.add(getCar());
  return Scaffold(
    appBar: appBarDefault("Carros"),
    body: carsBody(),
    backgroundColor: Colors.black,
  );
}

Container carsBody() {
  return Container(
    child: ListView.builder(
      itemCount: carList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkResponse(
          child: itemCard(carList[index]),
          onTap: () {
            navigateToDetail(carList[index], context);
          },
        );
      },
    ),
  );
}

Container itemCard(Car car) {
  var carFullName = car.brand.name + " " + car.vehicle.name;
  var carFullVersion =
      car.vehicle.version + " - " + "Ano: " + car.year.toString();
  var carPhotoUrl = car.photoGallery[0].photoPath;
  return Container(
    margin: new EdgeInsets.all(8),
    child: itemCardColumns(carFullName, carFullVersion, carPhotoUrl),
    decoration: itemCardDecotation(),
    padding: new EdgeInsets.only(top: 16, left: 8, right: 8, bottom: 8),
  );
}

BoxDecoration itemCardDecotation() {
  return BoxDecoration(
    borderRadius: BorderRadius.all(new Radius.circular(2)),
    color: Color(0xFF1A1A1A),
  );
}

Column itemCardColumns(
    String carFullName, String carFullVersion, String carPhotoUrl) {
  return Column(
    children: <Widget>[
      itemCardDescriptionRow(carFullName, 18, FontWeight.bold),
      itemCardDescriptionRow(carFullVersion, 16, FontWeight.normal),
      itemCardImage(carPhotoUrl)
    ],
    mainAxisSize: MainAxisSize.min,
  );
}

Row itemCardDescriptionRow(String message, double fontSize, FontWeight weight) {
  return Row(
    children: <Widget>[
      Text(
        message,
        style: TextStyle(
            color: Colors.white60, fontSize: fontSize, fontWeight: weight),
      )
    ],
  );
}

Container itemCardImage(String photoUrl) {
  return Container(
    child: Stack(
      children: <Widget>[
        carImageLoading(),
        carImage(photoUrl),
      ],
    ),
    padding: new EdgeInsets.only(top: 16),
    height: 290,
  );
}

Container carImage(String photoUrl) {
  return Container(
    child: Center(
      child: FadeInImage.memoryNetwork(
        image: photoUrl,
        placeholder: kTransparentImage,
      ),
    ),
  );
}

Container carImageLoading() {
  return Container(
    child: Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: new AlwaysStoppedAnimation<Color>(Colors.white60),
      ),
    ),
  );
}
