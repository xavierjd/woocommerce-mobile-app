import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_store/woocommerce/models/customer_detail_model.dart';
import 'package:woo_store/woocommerce/models/order_model.dart';
import 'package:woo_store/woocommerce/provider/cart_provider.dart';
import 'package:woo_store/woocommerce/provider/customer_details_provider.dart';
import 'package:woo_store/woocommerce/woocommerce_const.dart';

class OrderProvider with ChangeNotifier {
  bool _isOrderCreated = false;

  late CreateOrderModel _createOrder;
  bool get isOrderCreated => _isOrderCreated;

  List<OrderModel> _orderList = [];
  List<OrderModel> get allOrders => _orderList;
  int get totalRecords => _orderList.length;

  void processOrder(CreateOrderModel orderModel) {
    _createOrder = orderModel;
    notifyListeners();
  }

  Future<void> createOrder({
    required BuildContext context,
  }) async {
    final customerModelDetailsProvider =
        Provider.of<CustomerDetailsProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final cartItems = cartProvider.getCartItems;

    if (customerModelDetailsProvider.getCustomerDetailsModel!.shipping !=
        null) {
      _createOrder.shipping =
          customerModelDetailsProvider.getCustomerDetailsModel!.shipping;
    }

    List<LineItems> lineItems = [];
    for (var item in cartItems) {
      lineItems.add(
        LineItems(
          productId: item.productId,
          quantity: item.qty,
          //variationId: null,
        ),
      );
    }

    _createOrder.lineItems = lineItems;

    final bool isCreated = await apiWoocommerce.createOrder(_createOrder);

    if (isCreated) {
      _isOrderCreated = true;
      notifyListeners();
    }
  }

  void fetchOrders() async {
    List<OrderModel> orderList = await apiWoocommerce.getOrders();

    if (orderList.isNotEmpty) {
      _orderList = orderList;
    }
    notifyListeners();
  }
}
