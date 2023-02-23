import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:woo_store/services/shared_services.dart';

import 'package:woo_store/woocommerce/woocommerce_const.dart';
import 'package:woo_store/woocommerce/models/cart_reponse_model.dart';
import 'package:woo_store/woocommerce/models/cart_request_model.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];
  List<CartItem> get getCartItems => _cartItems;

  double get totalAmount => _cartItems.isNotEmpty
      ? _cartItems
          .map<double>((e) => e.lineSubtotal)
          .reduce((value, element) => value + element)
      : 0.0;

  Future<void> addToCart({
    required CartProducts product,
  }) async {
    List<CartProducts> productList = [];

    if (_cartItems.isEmpty) {
      productList.add(product);

      final requestModel = CartRequestModel(
        userId: 1,
        products: productList,
      );

      final cartResponseModel =
          await apiWoocommerce.addToCart(model: requestModel);
      if (cartResponseModel.data != null) {
        _cartItems.clear();
        _cartItems.addAll(cartResponseModel.data!);
        notifyListeners();
      }
    } else {
      for (var element in _cartItems) {
        productList.add(
          CartProducts(
            productId: element.productId,
            quantity: element.qty,
          ),
        );
      }
      var requestModel = CartRequestModel(
        userId: 1,
        products: productList,
      );

      final isProductExist = requestModel.products!.firstWhereOrNull(
        (element) => element.productId == product.productId,
      );

      if (isProductExist != null) {
        requestModel.products!.remove(isProductExist);
      }

      requestModel.products!.add(product);

      final cartResponseModel =
          await apiWoocommerce.addToCart(model: requestModel);
      if (cartResponseModel.data != null) {
        _cartItems.clear();
        _cartItems.addAll(cartResponseModel.data!);
        notifyListeners();
      }
    }
  }

  Future<void> fetchCartItem() async {
    bool isLoggedIn = await SharedService.isLoggedIn();
    if (isLoggedIn) {
      final cartResponseModel = await apiWoocommerce.getCartItems();
      if (cartResponseModel.data != null) {
        _cartItems.clear();
        _cartItems.addAll(cartResponseModel.data!);
        notifyListeners();
      }
    }
  }

  void updateQty({
    required int productId,
    required int qty,
  }) {
    if (_cartItems.isNotEmpty) {
      var isProductExistIndex =
          _cartItems.indexWhere((element) => element.productId == productId);
      if (isProductExistIndex != -1) {
        _cartItems[isProductExistIndex].qty = qty;
        notifyListeners();
      }
    }
  }

  Future<void> updateCart() async {
    List<CartProducts> productList = [];
    for (var element in _cartItems) {
      productList.add(
        CartProducts(
          productId: element.productId,
          quantity: element.qty,
        ),
      );
    }

    var requestModel = CartRequestModel(
      userId: 1,
      products: productList,
    );
    final cartResponseModel =
        await apiWoocommerce.addToCart(model: requestModel);
    if (cartResponseModel.data != null) {
      _cartItems.clear();
      _cartItems.addAll(cartResponseModel.data!);
      notifyListeners();
    }
  }

  void removeItem({required int productId}) {
    if (_cartItems.isNotEmpty) {
      var isProductExist = _cartItems
          .firstWhereOrNull((element) => element.productId == productId);
      if (isProductExist != null) {
        _cartItems.remove(isProductExist);
        notifyListeners();
      }
    }
  }
}
