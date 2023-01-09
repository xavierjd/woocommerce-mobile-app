import 'package:flutter/material.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:woo_store/inner_screens/product_details_screen.dart';
import 'package:woo_store/services/utils.dart';
import 'package:woo_store/widgets/heart_widget.dart';
import 'package:woo_store/widgets/price_widget.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/woocommerce/models/product_model.dart';

class FeedItemWidget extends StatefulWidget {
  const FeedItemWidget({super.key});

  @override
  State<FeedItemWidget> createState() => _FeedItemWidgetState();
}

class _FeedItemWidgetState extends State<FeedItemWidget> {
  final _quantityTextCotroller = TextEditingController();
  @override
  void initState() {
    _quantityTextCotroller.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextCotroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size sizeScreen = Utils(context).getScreenSize;
    final productModel = Provider.of<ProductModel>(context);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsScreen.routeName,
            arguments: productModel);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Color(0xfff8f8f8),
              blurRadius: 15,
              spreadRadius: 10,
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Visibility(
                    visible: productModel.calcuatedDiscount() > 0,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: TextWidget(
                          text: '${productModel.calcuatedDiscount()}% OFF',
                          color: Colors.white,
                          textSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // CircleAvatar(
                        //   radius: 30,
                        //   backgroundColor: ,
                        // )
                        Image.network(
                          productModel.images!.isNotEmpty
                              ? productModel.images!.first.src
                              : 'https://bitfun.mx/wp-content/uploads/woocommerce-placeholder.png',
                          height: sizeScreen.width * 0.22,
                          width: sizeScreen.width * 0.22,
                        )
                      ],
                    ),
                  ),
                  _productTitle(productModel.name),
                  _productPrice(
                    productModel.salePrice,
                    productModel.regularPrice,
                    productModel.isOnSale,
                  ),
                  //addToCartButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Material(
    //     borderRadius: BorderRadius.circular(12),
    //     color: Theme.of(context).cardColor,
    //     child: InkWell(
    //       onTap: () {
    //         //viewedProdProvider.addProductToHistory(productID: productsModel.id);
    //         Navigator.pushNamed(context, ProductDetails.routeName,
    //             arguments: productModel);
    //       },
    //       child: Column(
    //         children: [
    //           Visibility(
    //             visible: productModel.calcuatedDiscount() > 0,
    //             child: Align(
    //               alignment: Alignment.bottomLeft,
    //               child: Container(
    //                 padding: const EdgeInsets.all(5),
    //                 decoration: BoxDecoration(
    //                   color: Colors.green,
    //                   borderRadius: BorderRadius.circular(50),
    //                 ),
    //                 child: TextWidget(
    //                   text: '${productModel.calcuatedDiscount()}% OFF',
    //                   color: Colors.white,
    //                   textSize: 15,
    //                 ),
    //               ),
    //             ),
    //           ),
    //           FancyShimmerImage(
    //             imageUrl: productModel.images!.first.src,
    //             height: sizeScreen.width * 0.22,
    //             width: sizeScreen.width * 0.22,
    //             boxFit: BoxFit.fill,
    //           ),
    //           _productTitle(productModel.name),
    //           _productPrice(productModel.salePrice, productModel.regularPrice,
    //               productModel.isOnSale),
    //           const Spacer(),
    //           addToCartButton(),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget _productTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 3,
            child: TextWidget(
              text: title,
              color: Colors.black,
              textSize: 18,
              maxLines: 2,
              isTitle: true,
            ),
          ),
          const Flexible(
            flex: 1,
            child: HeartWidget(),
          ),
        ],
      ),
    );
  }

  Widget _productPrice(double salePrice, double regularPrice, bool isOnSale) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PriceWidget(
            salePrice: salePrice,
            price: regularPrice,
            textPrice: _quantityTextCotroller.text,
            isOnSale: isOnSale,
          ),
          const SizedBox(
            width: 8,
          ),
          addCurrency(),
        ],
      ),
    );
  }

  Widget addCurrency() {
    return Flexible(
      child: Row(
        children: [
          FittedBox(
            child: TextWidget(
              //text: productsModel.isPiece ? 'Piece' : 'KG',
              text: 'MXN',
              color: Colors.black,
              textSize: 18,
              isTitle: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget addToCartButton() {
    return SizedBox(
      //width: double.infinity,
      child: TextButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
            ),
          ),
          child: Icon(
            FontAwesomeIcons.cartShopping,
            color: Colors.white,
          )),
    );
  }
}
