import 'dart:convert';

import 'package:cars_dealer/models/brand/brand.dart';
import 'package:cars_dealer/models/photo-gallery/photo-gallery.dart';
import 'package:cars_dealer/models/vehicle/vehicle.dart';

List<Car> welcomeFromJson(String str) =>
    new List<Car>.from(json.decode(str).map((x) => Car.fromJson(x)));

String welcomeToJson(List<Car> data) =>
    json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Car {
  String id;
  Brand brand;
  Vehicle vehicle;
  int year;
  List<PhotoGallery> photoGallery;
  String description;

  Car({
    this.id,
    this.brand,
    this.vehicle,
    this.year,
    this.photoGallery,
    this.description,
  });

  factory Car.fromJson(Map<String, dynamic> json) => new Car(
        id: json["id"],
        brand: Brand.fromJson(json["brand"]),
        vehicle: Vehicle.fromJson(json["vehicle"]),
        year: json["year"],
        photoGallery: new List<PhotoGallery>.from(
            json["photoGallery"].map((x) => PhotoGallery.fromJson(x))),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand": brand.toJson(),
        "vehicle": vehicle.toJson(),
        "year": year,
        "photoGallery":
            new List<dynamic>.from(photoGallery.map((x) => x.toJson())),
        "description": description,
      };
}
