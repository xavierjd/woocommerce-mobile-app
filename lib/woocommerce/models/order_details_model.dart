import 'package:woo_store/woocommerce/models/customer_detail_model.dart';

class OrderDetailsModel {
  int orderId;
  String orderNumber;
  String paymentMethod;
  String orderStatus;
  DateTime orderDate;
  Shipping? shipping;
  List<LineItems>? lineItems;
  double itemTotalAmount;
  double totalAmount;
  double shippingTotal;

  OrderDetailsModel({
    required this.orderId,
    required this.orderNumber,
    required this.paymentMethod,
    required this.orderStatus,
    required this.orderDate,
    required this.shipping,
    required this.lineItems,
    required this.itemTotalAmount,
    required this.totalAmount,
    required this.shippingTotal,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        orderId: json['id'],
        orderNumber: json['order_key'],
        paymentMethod: json['payment_method_title'],
        orderStatus: json['status'],
        orderDate: DateTime.parse(json['date_created']),
        shipping: json['shipping'] != null
            ? Shipping.fromJson(json['shipping'])
            : null,
        lineItems: json['line_items'] != null
            ? List<LineItems>.from(json['line_items']
                .map((element) => LineItems.fromJson(element)))
            : null,
        itemTotalAmount: json['line_items'] != null
            ? List<double>.from(
                json['line_items'].map(
                  (element) => double.parse(element['total']),
                ),
              ).reduce((a, b) => a + b)
            : 0,
        totalAmount: double.parse(json['total']),
        shippingTotal: double.parse(json['shipping_total']),
      );
}

class LineItems {
  int productId;
  String productName;
  int quantity;
  int variationId;
  double totalAmount;

  LineItems({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.variationId,
    required this.totalAmount,
  });

  factory LineItems.fromJson(Map<String, dynamic> json) => LineItems(
        productId: json['product_id'],
        productName: json['name'],
        quantity: json['quantity'],
        variationId: json['variation_id'],
        totalAmount: double.parse(json['total']),
      );
}
