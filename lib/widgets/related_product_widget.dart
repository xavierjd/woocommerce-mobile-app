import 'package:flutter/material.dart';

class RelatedProductsWidget extends StatefulWidget {
  const RelatedProductsWidget({
    super.key,
    required this.labelName,
    required this.products,
  });

  final String labelName;
  final List<int> products;

  @override
  State<RelatedProductsWidget> createState() => _RelatedProductsWidgetState();
}

class _RelatedProductsWidgetState extends State<RelatedProductsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
