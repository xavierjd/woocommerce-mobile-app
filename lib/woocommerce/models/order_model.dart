import 'package:flutter/cupertino.dart';
import 'package:woo_store/woocommerce/models/customer_detail_model.dart';

class CreateOrderModel {
  int customerId;
  String paymentMethod;
  String paymentMethodTitle;
  bool setPaid;
  String transactionId;
  List<LineItems>? lineItems;
  Shipping? shipping;

  CreateOrderModel({
    required this.customerId,
    required this.paymentMethod,
    required this.paymentMethodTitle,
    required this.setPaid,
    required this.transactionId,
    this.shipping,
    this.lineItems,
  });

  Map<String, dynamic> toJson() => {
        'customer_id': customerId,
        'payment_method': paymentMethod,
        'payment_method_title': paymentMethodTitle,
        'set_paid': setPaid,
        'transaction_id': transactionId,
        'shipping': shipping != null ? shipping!.toJson() : null,
        'line_items': lineItems != null
            ? lineItems!.map((e) => e.toJson()).toList()
            : null
      };
}

class LineItems {
  int productId;
  int quantity;
  //int? variationId;

  LineItems({
    required this.productId,
    required this.quantity,
    // required this.variationId,
  });

  Map<String, dynamic> toJson() => {
        'product_id': productId,
        'quantity': quantity,
        //'variation_id': variationId ?? '',
      };
}

class OrderModel with ChangeNotifier {
  int customerId;
  int orderId;
  String orderNumber;
  String status;
  DateTime orderDate;

  OrderModel({
    required this.customerId,
    required this.orderId,
    required this.status,
    required this.orderNumber,
    required this.orderDate,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        customerId: json['customer_id'],
        orderId: json['id'],
        status: json['status'],
        orderNumber: json['order_key'],
        orderDate: DateTime.parse(json['date_created']),
      );
}
