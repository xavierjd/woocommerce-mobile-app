import 'package:flutter/material.dart';
import 'package:woo_store/woocommerce/models/product_model.dart';
import 'package:woo_store/woocommerce/woocommerce_const.dart';

class SortBy {
  String value;
  String text;
  String sortOder;
  SortBy({
    required this.value,
    required this.text,
    required this.sortOder,
  });
}

enum LoadMoreStatus {
  initial,
  loading,
  stable,
}

class ProductProvider with ChangeNotifier {
  final List<ProductModel> _productList = [];

  SortBy _sortBy = SortBy(value: 'modified', text: 'Latest', sortOder: 'asc');

  final int _pageSize = 10;

  List<ProductModel> get allProducts => _productList;
  // double get totalRecords => _productList.length.toDouble();
  clearProductList() {
    _productList.clear();
    notifyListeners();
  }

  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.stable;
  getLoadMoreStatus() => _loadMoreStatus;

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }

  setSortOrder(SortBy sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  fetchProducts({
    int? pageNumber,
    String? strSearch,
    String? tagName,
    int? categoryId,
    String? sortBy,
    String sortOrder = 'asc',
  }) async {
    List<ProductModel> itemModel = await apiWoocommerce.getProducts(
      strSearch: strSearch,
      tagName: tagName,
      pageNumber: pageNumber,
      categoryId: categoryId,
      pageSize: _pageSize,
      sortBy: _sortBy.value,
      sortOrder: _sortBy.sortOder,
    );

    if (itemModel.isNotEmpty) {
      _productList.addAll(itemModel);
    }

    setLoadingState(LoadMoreStatus.stable);
    notifyListeners();
  }
}
