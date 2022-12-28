import 'package:flutter/foundation.dart';

class CategoryModel with ChangeNotifier {
  int categoryId;
  String categoryName;
  String categoryDesc;
  int parent;
  Img? image;

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
      image: json['image'] == null ? null : Img.fromJson(json['image']),
    );
  }
}

class Img with ChangeNotifier {
  String url;
  Img({
    required this.url,
  });

  factory Img.fromJson(Map<String, dynamic> json) {
    return Img(url: json['src']);
  }
}
