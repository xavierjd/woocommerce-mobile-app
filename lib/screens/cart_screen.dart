import 'package:flutter/material.dart';
import 'package:woo_store/widgets/appbar_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
          title: 'Carrito', backgroundColor: Colors.pinkAccent),
      body: Column(
        children: const [
          Expanded(
            child: Center(
              child: Text('Carrito'),
            ),
          ),
        ],
      ),
    );
  }
}
