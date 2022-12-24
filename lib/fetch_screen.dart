import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:woo_store/screens/bottom_bar_screen.dart';
import 'package:woo_store/woo_provider/categories_provider.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({super.key});

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 5), () async {
      final categoriesProvider =
          Provider.of<CategoriesProvider>(context, listen: false);
      await categoriesProvider.fetchCategories();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BottomBarScreen(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.pinkAccent,
          ),
          const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
