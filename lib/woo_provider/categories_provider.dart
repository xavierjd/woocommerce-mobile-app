import 'package:flutter/material.dart';
import 'package:woo_store/woocommerce/models/category_model.dart';
import 'package:woo_store/woocommerce/woocommerce_const.dart';

class CategoriesProvider with ChangeNotifier {
  List<CategoryModel> _categoriesList = [];

  List<CategoryModel> get getCategoriesList {
    return _categoriesList;
  }

  Future<void> fetchCategories() async {
    _categoriesList = await apiWoocommerce.getCategories();
    notifyListeners();
  }
}
