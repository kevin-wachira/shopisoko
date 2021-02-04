// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    Product({
        this.id,
        this.name,
        this.sku,
        this.price,
        this.discount,
        this.qty,
        this.quantity,
        this.stockStatus,
        this.image,
        this.date,
    });

    String id;
    String name;
    String sku;
    String price;
    String discount;
    String qty;
    String quantity;
    String stockStatus;
    String image;
    String date;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        sku: json["sku"],
        price: json["price"],
        discount: json["discount"],
        qty: json["qty"],
        quantity: json["quantity"],
        stockStatus: json["stock_status"],
        image: json["image"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sku": sku,
        "price": price,
        "discount": discount,
        "qty": qty,
        "quantity": quantity,
        "stock_status": stockStatus,
        "image": image,
        "date": date,
    };
}
