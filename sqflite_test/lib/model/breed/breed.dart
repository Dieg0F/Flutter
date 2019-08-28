// To parse this JSON data, do
//
//     final breedsResults = breedsResultsFromJson(jsonString);

import 'dart:convert';

class BreedsResults {
  List<Breed> breeds;

  BreedsResults({
    this.breeds,
  });

  factory BreedsResults.fromJson(String str) =>
      BreedsResults.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BreedsResults.fromMap(Map<String, dynamic> json) => new BreedsResults(
        breeds:
            new List<Breed>.from(json["breeds"].map((x) => Breed.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "breeds": new List<dynamic>.from(breeds.map((x) => x.toMap())),
      };
}

class Breed {
  int id;
  bool isActive;
  int weight;
  int size;
  String picture;
  String name;
  String about;
  String registered;

  Breed({
    this.id,
    this.isActive,
    this.weight,
    this.size,
    this.picture,
    this.name,
    this.about,
    this.registered,
  });

  factory Breed.fromJson(String str) => Breed.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Breed.fromMap(Map<String, dynamic> json) => new Breed(
        id: json["id"],
        name: json["name"],
        about: json["about"],
        registered: json["registered"],
        size: json["size"],
        weight: json["weight"],
        picture: json["picture"],
        isActive: json["isActive"] == 'true' ? true : false,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "isActive": isActive,
        "weight": weight,
        "size": size,
        "picture": picture,
        "name": name,
        "about": about,
        "registered": registered,
      };
}
