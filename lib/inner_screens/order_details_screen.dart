import 'package:flutter/material.dart';
import 'package:woo_store/Utils/checkpoints_widget.dart';
import 'package:woo_store/widgets/appbar_widget.dart';
import 'package:woo_store/woocommerce/models/order_details_model.dart';
import 'package:woo_store/woocommerce/woocommerce_const.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const routeName = 'ordersDetails';
  const OrderDetailsScreen({
    super.key,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderId = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Orders Details',
        backgroundColor: Colors.pinkAccent,
      ),
      body: FutureBuilder(
        future: apiWoocommerce.getOrderDetails(orderId: orderId),
        builder: (
          BuildContext context,
          AsyncSnapshot<OrderDetailsModel> orderDetailsModel,
        ) {
          if (orderDetailsModel.hasData) {
            return orderDetailsUI(orderDetailsModel.data!);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget orderDetailsUI(OrderDetailsModel model) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '#${model.orderId.toString()}',
            style: Theme.of(context).textTheme.labelHeading,
          ),
          Text(
            model.orderDate.toString(),
            style: Theme.of(context).textTheme.labelText,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Delivered To',
            style: Theme.of(context).textTheme.labelHeading,
          ),
          Text(
            model.shipping!.address1,
            style: Theme.of(context).textTheme.labelText,
          ),
          Text(
            model.shipping!.address2,
            style: Theme.of(context).textTheme.labelText,
          ),
          Text(
            '${model.shipping!.city}, ${model.shipping!.state}',
            style: Theme.of(context).textTheme.labelText,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Payment Method',
            style: Theme.of(context).textTheme.labelHeading,
          ),
          Text(
            model.paymentMethod,
            style: Theme.of(context).textTheme.labelText,
          ),
          const Divider(color: Colors.grey),
          const SizedBox(
            height: 5,
          ),
          const CheckPoints(
            checkedTill: 0,
            checkPoints: ['Processing', 'Shipping', 'Delivered'],
            checkPointFilledColor: Colors.redAccent,
          ),
          const Divider(
            color: Colors.grey,
          ),
          _listOrderItems(model),
          const Divider(
            color: Colors.grey,
          ),
          _itemTotal(
            label: 'Item Total',
            value: '${model.itemTotalAmount}',
            textStyle: Theme.of(context).textTheme.itemTotalText,
          ),
          _itemTotal(
            label: 'Shipping Charges',
            value: '${model.shippingTotal}',
            textStyle: Theme.of(context).textTheme.itemTotalText,
          ),
          _itemTotal(
            label: 'Paid',
            value: '${model.totalAmount}',
            textStyle: Theme.of(context).textTheme.itemTotalPaidText,
          ),
        ],
      ),
    );
    ;
  }

  Widget _listOrderItems(OrderDetailsModel model) {
    return ListView.builder(
      itemCount: model.lineItems!.length,
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _productItems(model.lineItems![index]);
      },
    );
  }

  Widget _productItems(LineItems product) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.all(2),
      onTap: () {},
      title: Text(
        product.productName,
        style: Theme.of(context).textTheme.productItemText,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.all(1),
        child: Text('Qty: ${product.quantity}'),
      ),
      trailing: Text('\$MXN ${product.totalAmount}'),
    );
  }

  Widget _itemTotal({
    required String label,
    required String value,
    required TextStyle textStyle,
  }) {
    return ListTile(
      dense: true,
      visualDensity: const VisualDensity(
        horizontal: 0,
        vertical: -4,
      ),
      contentPadding: const EdgeInsets.fromLTRB(2, -10, 2, -10),
      title: Text(
        label,
        style: textStyle,
      ),
      trailing: Text('\$MXN $value'),
    );
  }
}

extension CustomStyle on TextTheme {
  TextStyle get labelHeading {
    return const TextStyle(
      fontSize: 16,
      color: Colors.redAccent,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get labelText {
    return const TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get productItemText {
    return const TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle get itemTotalText {
    return const TextStyle(
      fontSize: 14,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle get itemTotalPaidText {
    return const TextStyle(
      fontSize: 16,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    );
  }
}
