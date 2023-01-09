import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_store/widgets/appbar_widget.dart';
import 'package:woo_store/widgets/categories_widget.dart';

import 'package:woo_store/woo_provider/categories_provider.dart';
import 'package:woo_store/woocommerce/models/category_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<CategoriesProvider>(context);
    List<CategoryModel> allCategories = categoriesProvider.getCategoriesList;
    return Scaffold(
      appBar: const AppBarWidget(
          title: 'Categorias', backgroundColor: Colors.pinkAccent),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 240 / 250,
          crossAxisSpacing: 10, // Vertical spacing
          mainAxisSpacing: 10, // Horizontal spacing
          children: List.generate(allCategories.length, (index) {
            return ChangeNotifierProvider.value(
              value: allCategories[index],
              child: const CategoriesWidget(),
            );
          }),
        ),
      ),
    );
  }
}
