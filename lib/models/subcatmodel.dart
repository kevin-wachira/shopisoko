// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

//SubCategories subcategoriesFromJson(String str) => SubCategories.fromJson(json.decode(str));

//String subcategoriesToJson(SubCategories data) => json.encode(data.toJson());

class SubCategories {
    SubCategories({
        this.id,
        this.subcategory,
        this.cat_id,
        this.image
    });

    int id;
    String subcategory;
    int cat_id;
    String image;

    factory SubCategories.fromJson(Map<String, dynamic> json) => SubCategories(
        id: int.parse(json["id"]),
        subcategory: json["subcategory"],
        cat_id: int.parse(json['cat_id']),
        image: json['image']
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "subcategory": subcategory,
        'cat_id':cat_id,
         'image':image
    };
}