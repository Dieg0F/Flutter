// To parse this JSON data, do
//
//     final ProfileResponse = ProfileResponseFromJson(jsonString);

import 'dart:convert';

class ProfileResponse {
  List<Profile> results;

  ProfileResponse({
    this.results,
  });

  factory ProfileResponse.fromJson(String str) =>
      ProfileResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProfileResponse.fromMap(Map<String, dynamic> json) =>
      new ProfileResponse(
        results: new List<Profile>.from(
            json["results"].map((x) => Profile.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "results": new List<dynamic>.from(results.map((x) => x.toMap())),
      };
}

class Profile {
  String id;
  bool isActive;
  String picture;
  int age;
  String eyeColor;
  Name name;
  String company;
  String email;
  String phone;
  String address;
  String about;
  String registered;
  String latitude;
  String longitude;
  List<Photo> photos;

  Profile({
    this.id,
    this.isActive,
    this.picture,
    this.age,
    this.eyeColor,
    this.name,
    this.company,
    this.email,
    this.phone,
    this.address,
    this.about,
    this.registered,
    this.latitude,
    this.longitude,
    this.photos,
  });

  factory Profile.fromJson(String str) => Profile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Profile.fromMap(Map<String, dynamic> json) => new Profile(
        id: json["_id"],
        isActive: json["isActive"],
        picture: json["picture"],
        age: json["age"],
        eyeColor: json["eyeColor"],
        name: Name.fromMap(json["name"]),
        company: json["company"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        about: json["about"],
        registered: json["registered"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        photos:
            new List<Photo>.from(json["photos"].map((x) => Photo.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "isActive": isActive,
        "picture": picture,
        "age": age,
        "eyeColor": eyeColor,
        "name": name.toMap(),
        "company": company,
        "email": email,
        "phone": phone,
        "address": address,
        "about": about,
        "registered": registered,
        "latitude": latitude,
        "longitude": longitude,
        "photos": new List<dynamic>.from(photos.map((x) => x.toMap())),
      };
}

class Name {
  String first;
  String last;

  Name({
    this.first,
    this.last,
  });

  factory Name.fromJson(String str) => Name.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Name.fromMap(Map<String, dynamic> json) => new Name(
        first: json["first"],
        last: json["last"],
      );

  Map<String, dynamic> toMap() => {
        "first": first,
        "last": last,
      };
}

class Photo {
  String id;
  String name;
  String photo;
  String thumb;

  Photo({
    this.id,
    this.name,
    this.photo,
    this.thumb,
  });

  factory Photo.fromJson(String str) => Photo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Photo.fromMap(Map<String, dynamic> json) => new Photo(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        thumb: json["thumb"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "photo": photo,
        "thumb": thumb,
      };
}
