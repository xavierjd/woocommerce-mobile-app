import 'package:flutter/material.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/woocommerce/models/product_model.dart';
import 'package:woo_store/woocommerce/woocommerce_const.dart';

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
    return Container(
      color: const Color(0xffF4F7FA),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 4),
                child: TextWidget(
                  text: widget.labelName,
                  color: Colors.black,
                  textSize: 18,
                  isTitle: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, top: 4),
                child: TextButton(
                  onPressed: () {},
                  child: TextWidget(
                    text: 'Ver más',
                    color: Colors.lightBlue,
                    textSize: 18,
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
      future: apiWoocommerce.getProducts(productsIds: widget.products),
      builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> model) {
        if (model.hasData) {
          return _buildList(model.data!);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildList(List<ProductModel> items) {
    return Container(
      height: 230,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          var data = items[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                width: 130,
                height: 120,
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
                      )
                    ]),
                child: Image.network(
                  data.images!.first.src,
                  height: 120,
                ),
              ),
              Container(
                width: 130,
                alignment: Alignment.centerLeft,
                child: TextWidget(
                  text: data.name,
                  color: Colors.black,
                  textSize: 12,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 4, left: 4),
                width: 130,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    TextWidget(
                      text: '\$${data.regularPrice.toStringAsFixed(2)}',
                      color: Colors.green,
                      textSize: 12,
                    ),
                    // TextWidget(
                    //   text: '\$${data.salePrice.toStringAsFixed(2)}',
                    //   color: Colors.black,
                    //   textSize: 12,
                    // ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
