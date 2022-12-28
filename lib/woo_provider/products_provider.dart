import 'package:flutter/material.dart';
import 'package:woo_store/woocommerce/models/product_model.dart';
import 'package:woo_store/woocommerce/woocommerce_const.dart';

class ProductsProvider with ChangeNotifier {
  List<ProductModel> _productsList = [];

  List<ProductModel> get getProductsList {
    return _productsList;
  }

  Future<void> findByCategory(int categoryId) async {
    _productsList =
        await apiWoocommerce.getProducts(categoryId: categoryId.toString());
    notifyListeners();
  }
}
