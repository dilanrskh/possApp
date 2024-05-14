// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductResponseModel {
  final bool success;
  final String message;
  final List<Product> data;

  ProductResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ProductResponseModel.fromJson(String str) =>
      ProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponseModel.fromMap(Map<String, dynamic> json) =>
      ProductResponseModel(
        success: json["success"],
        message: json["message"],
        data: List<Product>.from(json["data"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Product {
  final int? id;
  final String name;
  final String? deskripsi;
  final int price;
  final int stock;
  final String category;
  final String image;
  final bool isBestSeller;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    this.id,
    required this.name,
    this.deskripsi,
    required this.price,
    required this.stock,
    required this.category,
    required this.image,
    this.isBestSeller = false,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        deskripsi: json["deskripsi"] ?? '',
        price: json["price"],
        stock: json["stock"],
        category: json["category"],
        image: json["image"] ?? '',
        isBestSeller: json["is_best_seller"] == 1 ? true : false,

        // createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "price": price,
        "stock": stock,
        "category": category,
        "image": image,
        "is_best_seller": isBestSeller ? 1 : 0,
      };

  Product copyWith({
    int? id,
    String? name,
    String? deskripsi,
    int? price,
    int? stock,
    String? category,
    String? image,
    bool? isBestSeller,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      deskripsi: deskripsi ?? this.deskripsi,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      category: category ?? this.category,
      image: image ?? this.image,
      isBestSeller: isBestSeller ?? this.isBestSeller,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }


  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.deskripsi == deskripsi &&
      other.price == price &&
      other.stock == stock &&
      other.category == category &&
      other.image == image &&
      other.isBestSeller == isBestSeller &&
      other.createdAt == createdAt &&
      other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      deskripsi.hashCode ^
      price.hashCode ^
      stock.hashCode ^
      category.hashCode ^
      image.hashCode ^
      isBestSeller.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
  }
}
