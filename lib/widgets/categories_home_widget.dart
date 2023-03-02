import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_store/inner_screens/product_list_screen.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/woocommerce/models/category_model.dart';

import '../woo_provider/categories_provider.dart';

class CategoriesHomeWidget extends StatefulWidget {
  const CategoriesHomeWidget({
    super.key,
  });

  @override
  State<CategoriesHomeWidget> createState() => _CategoriesHomeWidgetState();
}

class _CategoriesHomeWidgetState extends State<CategoriesHomeWidget> {
  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<CategoriesProvider>(context);
    List<CategoryModel> categories = categoriesProvider.getCategoriesList;
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: TextWidget(
                  text: 'Todas las categorias',
                  color: Colors.black,
                  textSize: 18,
                  isTitle: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 20),
                child: TextButton(
                  onPressed: () {},
                  child: TextWidget(
                    text: 'Ver más',
                    color: Colors.lightBlue,
                    textSize: 18,
                    isTitle: true,
                  ),
                ),
              ),
            ],
          ),
          _buildCategoryList(categories),
        ],
      ),
    );
  }

  Widget _buildCategoryList(List<CategoryModel> categories) {
    return Container(
      height: 150,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          var data = categories[index];
          return GestureDetector(
            onTap: () {
              // Navigator.pushNamed(
              //   context,
              //   ProductListScreen.routeName,
              //   arguments: data.categoryId,
              // );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductListScreen(
                    categoryId: data.categoryId,
                  ),
                ),
              );
            },
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 5),
                        blurRadius: 15,
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(
                        data.image == null
                            ? 'https://bitfun.mx/wp-content/uploads/woocommerce-placeholder.png'
                            : data.image!.url,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Row(
                  children: [
                    TextWidget(
                      text: data.categoryName,
                      color: Colors.black,
                      textSize: 12,
                      isTitle: true,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
