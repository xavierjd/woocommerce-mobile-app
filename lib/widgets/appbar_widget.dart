import 'package:flutter/material.dart';
import 'package:woo_store/widgets/text_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    required this.title,
    required this.backgroundColor,
  });

  final String title;
  final Color backgroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      centerTitle: true,
      title: TextWidget(
        text: title,
        color: Colors.white,
        textSize: 18,
        isTitle: true,
      ),
      elevation: 0,
    );
  }
}
