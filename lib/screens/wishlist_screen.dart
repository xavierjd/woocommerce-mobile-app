import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_store/widgets/appbar_widget.dart';
import 'package:woo_store/widgets/categories_widget.dart';

import 'package:woo_store/woo_provider/categories_provider.dart';
import 'package:woo_store/woocommerce/models/category_model.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
          title: 'Wishlist', backgroundColor: Colors.pinkAccent),
      body: Column(
        children: const [
          Expanded(
            child: Center(
              child: Text('Wishlist'),
            ),
          ),
        ],
      ),
    );
  }
}
