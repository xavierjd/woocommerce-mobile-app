import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  int id;
  String name;
  String description;
  String shortDescription;
  String sku;
  bool isOnSale;
  double price;
  double regularPrice;
  double salePrice;

  String stockStatus;
  int stockQty;
  List<Img>? images;
  List<Categories>? categories;
  List<int> relatedIds;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.shortDescription,
    required this.sku,
    required this.isOnSale,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.stockStatus,
    required this.stockQty,
    required this.images,
    required this.categories,
    required this.relatedIds,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        shortDescription: json['short_description'],
        sku: json['sku'],
        isOnSale: json['on_sale'],
        price: double.parse(json['price']),
        regularPrice: double.parse(json['regular_price']),
        salePrice: json['on_sale'] == true
            ? double.parse(json['sale_price'])
            : double.parse(json['regular_price']),
        stockStatus: json['stock_status'],
        stockQty: json['stock_quantity'],
        relatedIds: json['cross_sell_ids'].cast<int>(),
        images: json['images'] != null
            ? List<Img>.from(json['images'].map((index) => Img.fromJson(index)))
            : null,
        categories: json['categories'] != null
            ? List<Categories>.from(
                json['categories'].map((index) => Categories.fromJson(index)))
            : null,
      );

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

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

class Img with ChangeNotifier {
  String src;

  Img({
    required this.src,
  });

  factory Img.fromJson(Map<String, dynamic> json) => Img(
        src: json['src'],
      );
}
