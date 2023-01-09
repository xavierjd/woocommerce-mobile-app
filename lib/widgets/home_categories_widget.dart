import 'package:flutter/material.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/woocommerce/models/category_model.dart';
import 'package:woo_store/woocommerce/woocommerce_const.dart';

class HomeCategoriesWidget extends StatefulWidget {
  const HomeCategoriesWidget({super.key});

  @override
  State<HomeCategoriesWidget> createState() => _HomeCategoriesWidgetState();
}

class _HomeCategoriesWidgetState extends State<HomeCategoriesWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                child: TextWidget(
                  text: 'Ver más',
                  color: Colors.lightBlue,
                  textSize: 18,
                  isTitle: true,
                ),
              ),
            ],
          ),
          _categoriesList(),
        ],
      ),
    );
  }

  Widget _categoriesList() {
    return FutureBuilder(
        future: apiWoocommerce.getCategories(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<CategoryModel>> model,
        ) {
          if (model.hasData) {
            return _buildCategoryList(model.data);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _buildCategoryList(List<CategoryModel>? categories) {
    return Container(
      height: 150,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories!.length,
        itemBuilder: (context, index) {
          var data = categories[index];
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                width: 80,
                height: 80,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 5),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Image.network(
                  categories[index].image == null
                      ? 'https://bitfun.mx/wp-content/uploads/woocommerce-placeholder.png'
                      : data.image!.url,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                children: [
                  Text(categories[index].categoryName),
                  // const Icon(
                  //   Icons.keyboard_arrow_right,
                  //   size: 14,
                  // ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
