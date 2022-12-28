import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_store/widgets/categories_widget.dart';
import 'package:woo_store/widgets/feed_item_widget.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/woo_provider/products_provider.dart';

class CategoryInnerScreen extends StatefulWidget {
  static const routeName = "/CategoryInnerScreen";
  const CategoryInnerScreen({super.key});

  @override
  State<CategoryInnerScreen> createState() => _CategoryInnerScreenState();
}

class _CategoryInnerScreenState extends State<CategoryInnerScreen> {
  @override
  Widget build(BuildContext context) {
    final categoryParameters =
        ModalRoute.of(context)!.settings.arguments as CategoryParameters;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final productsList = productsProvider.getProductsList;
    return FutureBuilder(
        future: productsProvider.findByCategory(categoryParameters.categoryId),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: TextWidget(
                text: categoryParameters.categoryName,
                color: Colors.black,
                textSize: 18,
              ),
              centerTitle: true,
            ),
            body: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 240 / 250,
              crossAxisSpacing: 10, // Vertical spacing
              mainAxisSpacing: 10, // Horizontal spacing
              children: List.generate(productsList.length, (index) {
                return ChangeNotifierProvider.value(
                  value: productsList[index],
                  child: const FeedItemWidget(),
                );
              }),
            ),
          );
        });
  }
}
