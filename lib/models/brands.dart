// To parse this JSON data, do
//
//     final brands = brandsFromJson(jsonString);

import 'dart:convert';

Brands brandsFromJson(String str) => Brands.fromJson(json.decode(str));

String brandsToJson(Brands data) => json.encode(data.toJson());

class Brands {
    Brands({
        this.id,
        this.name,
        this.active,
    });

    String id;
    String name;
    String active;

    factory Brands.fromJson(Map<String, dynamic> json) => Brands(
        id: json["id"],
        name: json["name"],
        active: json["active"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "active": active,
    };
}
