import 'package:flutter/material.dart';

class CartResponseModel {
  bool status;
  List<CartItem>? data;

  CartResponseModel({
    required this.status,
    required this.data,
  });

  factory CartResponseModel.fromJson(Map<String, dynamic> json) =>
      CartResponseModel(
        status: json['status'],
        data: json['data'] != null
            ? List<CartItem>.from(
                json['data'].map((index) => CartItem.fromJson(index)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data != null ? data!.map((e) => e.toJson()).toList() : null,
      };
}

class CartItem with ChangeNotifier {
  int productId;
  String productName;
  String productRegularPrice;
  String productSalePrice;
  String thumbnail;
  int qty;
  double lineSubtotal;
  double lineTotal;

  CartItem({
    required this.productId,
    required this.productName,
    required this.productRegularPrice,
    required this.productSalePrice,
    required this.thumbnail,
    required this.qty,
    required this.lineSubtotal,
    required this.lineTotal,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        productId: json['product_id'],
        productName: json['product_name'],
        productRegularPrice: json['product_regular_price'],
        productSalePrice: json['product_sale_price'],
        thumbnail: json['thumbnail'],
        qty: json['qty'],
        lineSubtotal: double.parse(json['line_subtotal'].toString()),
        lineTotal: double.parse(json['line_total'].toString()),
      );

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'product_name': productName,
        'product_regular_price': productRegularPrice,
        'product_sale_price': productSalePrice,
        'thumbnail': thumbnail,
        'qty': qty,
        'line_subtotal': lineSubtotal,
        'line_total': lineTotal,
      };
}
