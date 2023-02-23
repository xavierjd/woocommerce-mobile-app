import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_store/inner_screens/order_details_screen.dart';
import 'package:woo_store/woocommerce/models/order_model.dart';

class OrdersWidgetItem extends StatelessWidget {
  const OrdersWidgetItem({super.key});

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderModel>(context);
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _orderStatus(status: order.status),
          const Divider(
            color: Colors.grey,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              iconText(
                iconWidget: const Icon(
                  Icons.edit,
                  color: Colors.redAccent,
                ),
                textWidget: const Text(
                  'Order ID',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                order.orderId.toString(),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              iconText(
                iconWidget: const Icon(
                  Icons.today,
                  color: Colors.redAccent,
                ),
                textWidget: const Text(
                  'Order Date',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                order.orderDate.toString(),
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    OrderDetailsScreen.routeName,
                    arguments: order.orderId,
                  );
                },
                icon: const Text(
                  'Orders Details',
                ),
                label: const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget iconText({
    required Icon iconWidget,
    required Text textWidget,
  }) {
    return Row(
      children: [
        iconWidget,
        const SizedBox(
          width: 5,
        ),
        textWidget,
      ],
    );
  }

  Widget _orderStatus({required String status}) {
    Icon icon = const Icon(Icons.clear, color: Colors.redAccent);
    Color color = Colors.redAccent;

    if (status == 'pending' || status == 'processing' || status == 'on-hold') {
      icon = const Icon(Icons.timer, color: Colors.orange);
      color = Colors.orange;
    } else if (status == 'completed') {
      icon = const Icon(
        Icons.check,
        color: Colors.green,
      );
      color = Colors.green;
    } else if (status == 'cancelled' ||
        status == 'refunded' ||
        status == 'failed') {
      icon = const Icon(Icons.clear, color: Colors.redAccent);
      color = Colors.redAccent;
    }

    return iconText(
      iconWidget: icon,
      textWidget: Text(
        'Order $status',
        style: TextStyle(
          fontSize: 15,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
