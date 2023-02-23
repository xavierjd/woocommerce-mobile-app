import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:woo_store/inner_screens/product_details_screen.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/woocommerce/models/product_model.dart';
import 'package:woo_store/woocommerce/woocommerce_const.dart';

class ProductsHomeWidget extends StatefulWidget {
  const ProductsHomeWidget({
    super.key,
    required this.labelName,
  });

  final String labelName;

  @override
  State<ProductsHomeWidget> createState() => _ProductsHomeWidgetState();
}

class _ProductsHomeWidgetState extends State<ProductsHomeWidget> {
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
                padding: const EdgeInsets.only(left: 16, top: 4),
                child: TextWidget(
                  text: widget.labelName,
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
          _productsList(),
        ],
      ),
    );
  }

  Widget _productsList() {
    return FutureBuilder(
        future: apiWoocommerce.getProducts(featured: true),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> model) {
          if (model.hasData) {
            return _buildList(model.data);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget _buildList(List<ProductModel>? items) {
    return Container(
      height: 240,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: items!.length,
        itemBuilder: (context, index) {
          var data = items[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                  arguments: data);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: 130,
                  height: 130,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 5),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: FancyShimmerImage(
                    imageUrl: data.images!.isNotEmpty
                        ? data.images!.first.src
                        : 'https://bitfun.mx/wp-content/uploads/woocommerce-placeholder.png',
                    boxFit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: 130,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    data.name,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4, left: 4),
                  width: 130,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Text(
                        '\$${data.regularPrice}',
                        style: const TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        ' \$${data.salePrice}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
