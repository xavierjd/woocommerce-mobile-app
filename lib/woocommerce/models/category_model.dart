import 'package:flutter/foundation.dart';

class CategoryModel with ChangeNotifier {
  int categoryId;
  String categoryName;
  String categoryDesc;
  int parent;
  Ima? image;

  CategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.categoryDesc,
    required this.parent,
    required this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['id'],
      categoryName: json['name'],
      categoryDesc: json['description'],
      parent: json['parent'],
      image: json['image'] == null ? null : Ima.fromJson(json['image']),
    );
  }
}

class Ima with ChangeNotifier {
  String url;
  Ima({
    required this.url,
  });

  factory Ima.fromJson(Map<String, dynamic> json) {
    return Ima(url: json['src']);
  }
}
