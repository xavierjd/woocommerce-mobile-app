import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_store/screens/bottom_bar_screen.dart';
import 'package:woo_store/widgets/loading_widget.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/woocommerce/provider/order_provider.dart';

class OrderSuccessScreen extends StatefulWidget {
  static const routeName = 'orderSuccess';
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  @override
  void initState() {
    super.initState();
    final createOrderProvider =
        Provider.of<OrderProvider>(context, listen: false);
    createOrderProvider.createOrder(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: LoadingWidget(
        isLoading: !orderProvider.isOrderCreated,
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.green.withOpacity(1),
                            Colors.green.withOpacity(0.2),
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 90,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Opacity(
                  opacity: 0.6,
                  child: Text(
                    'Your order has benn successfully submited!',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      BottomBarScreen.routeName,
                      (route) => false,
                    );
                  },
                  child: TextWidget(
                    text: 'Done',
                    textSize: 18,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
