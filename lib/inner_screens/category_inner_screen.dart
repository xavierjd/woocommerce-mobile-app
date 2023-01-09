import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_store/services/utils.dart';
import 'package:woo_store/widgets/appbar_widget.dart';
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
    Size screenSize = Utils(context).getScreenSize;
    final categoryParameters =
        ModalRoute.of(context)!.settings.arguments as CategoryParameters;
    final productsProvider = Provider.of<ProductsProvider>(context);
    final productsList = productsProvider.getProductsList;
    return FutureBuilder(
        future: productsProvider.findByCategory(categoryParameters.categoryId),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBarWidget(
              title: categoryParameters.categoryName,
              backgroundColor: Colors.pinkAccent,
            ),
            body: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              childAspectRatio: screenSize.width / (screenSize.height * 0.52),
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
