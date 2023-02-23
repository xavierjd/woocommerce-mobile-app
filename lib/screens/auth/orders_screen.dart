import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_store/widgets/appbar_widget.dart';
import 'package:woo_store/widgets/loading_widget.dart';
import 'package:woo_store/widgets/orders_wigdet_item.dart';
import 'package:woo_store/woocommerce/models/order_model.dart';
import 'package:woo_store/woocommerce/provider/order_provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = 'orders';
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();

    var orderProvider = Provider.of<OrderProvider>(context, listen: false);
    orderProvider.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: const AppBarWidget(
          title: 'Orders', backgroundColor: Colors.pinkAccent),
      body: LoadingWidget(
        isLoading: ordersProvider.totalRecords < 0,
        child: _listView(
          context,
          ordersProvider.allOrders,
        ),
      ),
    );
  }

  Widget _listView(BuildContext context, List<OrderModel> orders) {
    return ListView.builder(
        itemCount: orders.length,
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.all(8),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: ChangeNotifierProvider.value(
              value: orders[index],
              child: const OrdersWidgetItem(),
            ),
          );
        });
  }
}
