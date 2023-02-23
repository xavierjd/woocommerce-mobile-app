import 'package:flutter/material.dart';
import 'package:woo_store/widgets/text_widget.dart';

import '/services/utils.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.buttonText});
  final IconData icon;
  final String title, subtitle, buttonText;

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils(context).getScreenSize;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 200,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '¡Whoops!',
              style: TextStyle(
                color: Colors.red,
                fontSize: 40,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextWidget(
              text: title,
              color: Colors.black,
              textSize: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            TextWidget(
              text: subtitle,
              color: Colors.black,
              textSize: 20,
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: Colors.lightBlue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              onPressed: () {
                // GlobalMethods.navigateTo(
                //     ctx: context, routeName: FeedsScreen.routeName);
              },
              child: TextWidget(
                text: buttonText,
                textSize: 20,
                color: Colors.white,
                isTitle: true,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
