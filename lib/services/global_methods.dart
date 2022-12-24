import 'package:flutter/material.dart';

import '../widgets/text_widget.dart';

class GlobalMethods {
  static Future<void> warningDialog({
    required String title,
    required String subtitle,
    required Function fct,
    required BuildContext context,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(subtitle),
          actions: [
            TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  text: 'Cancelar',
                  color: Colors.cyan,
                  textSize: 18,
                )),
            TextButton(
              onPressed: () {
                fct();
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: TextWidget(
                text: 'OK',
                color: Colors.red,
                textSize: 18,
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<void> errorDialog({
    required String subtitle,
    required BuildContext context,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ocurrio un error:'),
          content: Text(subtitle),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: TextWidget(
                color: Colors.cyan,
                text: 'Ok',
                textSize: 18,
              ),
            ),
          ],
        );
      },
    );
  }
}
