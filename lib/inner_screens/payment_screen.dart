import 'package:flutter/material.dart';
import 'package:woo_store/widgets/appbar_widget.dart';
import 'package:woo_store/widgets/payment_method_list_item_widget.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/woocommerce/models/payment_method.dart';

class PaymentScreen extends StatefulWidget {
  static const routeName = '/Payment';
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final list = PaymentMethodList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Payment',
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 15,
            ),
            list.paymentsList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      leading: const Icon(
                        Icons.payment,
                        color: Colors.grey,
                      ),
                      title: TextWidget(
                        text: 'Payment Options',
                        color: Colors.black,
                        textSize: 18,
                      ),
                      subtitle: TextWidget(
                        text: 'Select your preffered Payment Mode',
                        color: Colors.grey,
                        textSize: 18,
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 0,
                  ),
            const SizedBox(
              height: 10,
            ),
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: list.paymentsList.length,
              itemBuilder: (context, index) {
                return PaymentMethodListItem(
                    paymentMehod: list.paymentsList.elementAt(index));
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
            ),
            list.cashList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      leading: const Icon(
                        Icons.monetization_on_outlined,
                        color: Colors.grey,
                      ),
                      title: TextWidget(
                        text: 'Cash on Delivery',
                        color: Colors.black,
                        textSize: 18,
                      ),
                      subtitle: TextWidget(
                        text: 'Select your preffered Payment Mode',
                        color: Colors.grey,
                        textSize: 18,
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 0,
                  ),
            ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount: list.cashList.length,
              itemBuilder: (context, index) {
                return PaymentMethodListItem(
                    paymentMehod: list.cashList.elementAt(index));
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
            ),
          ],
        ),
      ),
    );
  }
}
