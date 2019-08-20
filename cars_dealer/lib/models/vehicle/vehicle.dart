class Vehicle {
  String id;
  String name;
  String version;
  String engine;
  String fuel;
  String gear;
  String doors;

  Vehicle({
    this.id,
    this.name,
    this.version,
    this.engine,
    this.fuel,
    this.gear,
    this.doors,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => new Vehicle(
        id: json["id"],
        name: json["name"],
        version: json["version"],
        engine: json["engine"],
        fuel: json["fuel"],
        gear: json["gear"],
        doors: json["doors"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "version": version,
        "engine": engine,
        "fuel": fuel,
        "gear": gear,
        "doors": doors,
      };
}
