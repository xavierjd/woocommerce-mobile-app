import 'package:flutter/material.dart';
import 'package:woo_store/widgets/text_widget.dart';

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget({
    super.key,
    required this.fct,
    required this.buttonText,
  });
  final Function fct;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          fct();
        },
        child: TextWidget(
          text: buttonText,
          textSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
