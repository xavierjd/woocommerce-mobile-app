import 'package:flutter/material.dart';

import 'package:woo_store/widgets/text_widget.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.salePrice,
    required this.price,
    required this.textPrice,
    required this.isOnSale,
  });
  final double salePrice, price;
  final String textPrice;
  final bool isOnSale;

  @override
  Widget build(BuildContext context) {
    double userPrice = isOnSale ? salePrice : price;
    return Row(
      children: [
        TextWidget(
          text: '\$${(userPrice * int.parse(textPrice)).toStringAsFixed(2)}',
          color: Colors.black,
          textSize: 22,
          isTitle: true,
        ),
        const SizedBox(
          width: 5,
        ),
        Visibility(
          visible: isOnSale ? true : false,
          child: Text(
            '\$${(price * int.parse(textPrice)).toStringAsFixed(2)}',
            style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                decoration: TextDecoration.lineThrough),
          ),
        )
      ],
    );
  }
}
