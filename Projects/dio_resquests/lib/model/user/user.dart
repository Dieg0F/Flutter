class Location {
  final String street;
  final String city;
  final String state;

  Location(this.street, this.city, this.state);

  Location.fromJson(Map<String, dynamic> json)
      : street = json["street"],
        city = json["city"],
        state = json["state"];
}

class Name {
  final String title;
  final String first;
  final String last;

  Name(this.title, this.first, this.last);

  Name.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        first = json["first"],
        last = json["last"];
}

class Picture {
  final String large;
  final String medium;
  final String thumbnail;

  Picture(this.large, this.medium, this.thumbnail);

  Picture.fromJson(Map<String, dynamic> json)
      : large = json["large"],
        medium = json["medium"],
        thumbnail = json["thumbnail"];
}

class User {
  final String gender;
  final Name name;
  final Location location;
  final String email;
  final Picture picture;

  User(this.gender, this.name, this.location, this.email, this.picture);

  User.fromJson(Map<String, dynamic> json)
      : gender = json["gender"],
        name = Name.fromJson(json["name"]),
        location = Location.fromJson(json["location"]),
        email = json["email"],
        picture = Picture.fromJson(json["picture"]);
}
