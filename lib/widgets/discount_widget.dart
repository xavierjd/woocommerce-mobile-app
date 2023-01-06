import 'package:flutter/material.dart';

import 'package:woo_store/widgets/text_widget.dart';

class DiscountWidget extends StatelessWidget {
  const DiscountWidget({super.key, required this.discount});

  final int discount;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: discount > 0,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextWidget(
            text: '$discount% OFF',
            color: Colors.white,
            textSize: 15,
          ),
        ),
      ),
    );
  }
}
