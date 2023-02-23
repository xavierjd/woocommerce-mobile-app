import 'package:flutter/material.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/woocommerce/models/payment_method.dart';

class PaymentMethodListItem extends StatelessWidget {
  const PaymentMethodListItem({super.key, required this.paymentMehod});

  final PaymentMehod paymentMehod;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //splashColor: Colors.red,
      //focusColor: Colors.white,
      //highlightColor: Colors.redAccent,
      onTap: () {
        if (paymentMehod.isRouteRedirect) {
          Navigator.of(context).pushNamed(paymentMehod.route);
        } else {
          paymentMehod.onTap();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          //color: Theme.of(context).focusColor.withOpacity(0.1),
          color: Colors.grey.shade300.withOpacity(0.8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300.withOpacity(0.1),
              //color: Theme.of(context).focusColor.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
                image: DecorationImage(
                  image: AssetImage(paymentMehod.logo),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: paymentMehod.name,
                          color: Colors.black,
                          textSize: 18,
                          isTitle: true,
                          maxLines: 2,
                        ),
                        TextWidget(
                          text: paymentMehod.description,
                          color: Colors.grey,
                          textSize: 18,
                          isTitle: false,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
