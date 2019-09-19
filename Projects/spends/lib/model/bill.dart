// To parse this JSON data, do
//
//     final billResults = billResultsFromJson(jsonString);

import 'dart:convert';

class BillResults {
  List<Bill> bills;

  BillResults({
    this.bills,
  });

  factory BillResults.fromJson(String str) =>
      BillResults.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BillResults.fromMap(Map<String, dynamic> json) => new BillResults(
        bills: new List<Bill>.from(json["bills"].map((x) => Bill.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "bills": new List<dynamic>.from(bills.map((x) => x.toMap())),
      };
}

class Bill {
  String id;
  double price;
  String name;
  String where;
  String when;
  String type;

  Bill({
    this.id,
    this.price,
    this.name,
    this.where,
    this.when,
    this.type,
  });

  factory Bill.fromJson(String str) => Bill.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Bill.fromMap(Map<String, dynamic> json) => new Bill(
        id: json["id"],
        price: json["price"],
        name: json["name"],
        where: json["where"],
        when: json["when"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "price": price,
        "name": name,
        "where": where,
        "when": when,
        "type": type,
      };
}
