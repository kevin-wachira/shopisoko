// To parse this JSON data, do
//
//     final brand = brandFromJson(jsonString);

import 'dart:convert';

Brand brandFromJson(String str) => Brand.fromJson(json.decode(str));

String brandToJson(Brand data) => json.encode(data.toJson());

class Brand {
    Brand({
        this.id,
        this.brand,
        this.categories,
    });

    String id;
    String brand;
    List<Category> categories;

    factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        brand: json["brand"],
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "brand": brand,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    };
}

class Category {
    Category({
        this.id,
        this.name,
        this.subCategories,
    });

    String id;
    String name;
    List<SubCategory> subCategories;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        subCategories: List<SubCategory>.from(json["sub_categories"].map((x) => SubCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sub_categories": List<dynamic>.from(subCategories.map((x) => x.toJson())),
    };
}

class SubCategory {
    SubCategory({
        this.id,
        this.name,
    });

    String id;
    String name;

    factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
