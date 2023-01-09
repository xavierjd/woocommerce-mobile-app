import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  int id;
  String name;
  String description;
  String shortDescription;
  String sku;
  double price;
  double regularPrice;
  double salePrice;
  bool isOnSale;
  String stockStatus;
  List<Img>? images;
  List<Categories>? categories;
  List<int> relatedIds;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.sku,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.isOnSale,
    required this.stockStatus,
    required this.images,
    required this.categories,
    required this.relatedIds,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      shortDescription: json['short_description'],
      sku: json['sku'],
      price: json['price'] == "" ? 0.0 : double.parse(json['price']),
      regularPrice: json['regular_price'] == ""
          ? 0.0
          : double.parse(json['regular_price']),
      salePrice: json['sale_price'] == ""
          ? double.parse(json['regular_price'])
          : double.parse(json['sale_price']),
      isOnSale: json['on_sale'],
      stockStatus: json['stock_status'],
      relatedIds: json['cross_sell_ids'].cast<int>(),
      images: json['images'] != null
          ? List<Img>.from(json['images'].map((index) => Img.fromJson(index)))
          : null,
      categories: json['categories'] != null
          ? List<Categories>.from(
              json['categories'].map((index) => Categories.fromJson(index)))
          : null,
    );
  }
  calcuatedDiscount() {
    double regularPrice = this.regularPrice;
    double salePrice = this.salePrice != 0.0 ? this.salePrice : regularPrice;
    double discount = regularPrice - salePrice;
    double disPercent = (discount / regularPrice) * 100;
    return disPercent.round();
  }
}

class Categories with ChangeNotifier {
  int id;
  String name;

  Categories({
    required this.id,
    required this.name,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Img with ChangeNotifier {
  String src;

  Img({
    required this.src,
  });

  factory Img.fromJson(Map<String, dynamic> json) {
    return Img(
      src: json['src'],
    );
  }
}
