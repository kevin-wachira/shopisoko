// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
    Categories({
        this.id,
        this.name,
        this.image
    });

    String id;
    String name;
    String image;

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"],
        name: json["name"],
        image: json["image"]
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image":image
    };
}