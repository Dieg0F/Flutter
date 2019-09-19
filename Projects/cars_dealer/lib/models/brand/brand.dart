class Brand {
  String id;
  String name;
  String logo;

  Brand({
    this.id,
    this.name,
    this.logo,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => new Brand(
        id: json["id"],
        name: json["name"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
      };
}
