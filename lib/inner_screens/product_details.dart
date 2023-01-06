import 'package:flutter/material.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:woo_store/services/utils.dart';
import 'package:woo_store/widgets/discount_widget.dart';
import 'package:woo_store/widgets/expand_text_widget.dart';
import 'package:woo_store/widgets/stepper_widget.dart';

import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/woocommerce/models/product_model.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils(context).getScreenSize;

    final currProduct =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

    double usedPrice =
        currProduct.isOnSale ? currProduct.salePrice : currProduct.price;

    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () =>
                Navigator.canPop(context) ? Navigator.pop(context) : null,
            child: const Icon(
              IconlyLight.arrowLeft2,
              color: Colors.black,
              size: 24,
            ),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: Column(children: [
        Expanded(
          flex: 1,
          child: FancyShimmerImage(
            imageUrl: currProduct.images!.first.src,
            boxFit: BoxFit.scaleDown,
            width: screenSize.width,
            // height: screenHeight * .4,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child:
                      DiscountWidget(discount: currProduct.calcuatedDiscount()),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TextWidget(
                          text: currProduct.name,
                          color: Colors.black,
                          textSize: 25,
                          isTitle: true,
                        ),
                      ),
                      // HeartWidget(
                      //   productId: getCurrProduct.id,
                      //   isInWishlist: _isInWishlist,
                      // )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextWidget(
                        text: '\$${usedPrice.toStringAsFixed(2)}',
                        color: Colors.green,
                        textSize: 22,
                        isTitle: true,
                      ),
                      TextWidget(
                        text: 'MXN',
                        color: Colors.black,
                        textSize: 12,
                        isTitle: false,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Visibility(
                        visible: currProduct.isOnSale ? true : false,
                        child: Text(
                          '\$${currProduct.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      const Spacer(),

                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //       vertical: 4, horizontal: 8),
                      //   decoration: BoxDecoration(
                      //       color: Colors.lightBlue,
                      //       borderRadius: BorderRadius.circular(5)),
                      //   child: DiscountWidget(
                      //       discount: currProduct.calcuatedDiscount()),
                      // ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StepperWidget(
                        lowerLimit: 0,
                        upperLimit: 10,
                        stepValue: 1,
                        value: 0,
                        onChanged: (value) {},
                      ),
                      SizedBox(
                        //width: double.infinity,
                        child: TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.lightBlue),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                            ),
                          ),
                          child: TextWidget(
                            text: 'Agregar',
                            color: Colors.white,
                            maxLines: 1,
                            textSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: ExpandTextWidget(
                    labelHeader: 'Product Details',
                    desc: currProduct.description,
                    shortDesc: currProduct.shortDescription,
                  ),
                ),
                Divider(),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     quantityControl(
                //       fct: () {
                //         if (_quantityTextController.text == '1') {
                //           return;
                //         } else {
                //           setState(() {
                //             _quantityTextController.text =
                //                 (int.parse(_quantityTextController.text) - 1)
                //                     .toString();
                //           });
                //         }
                //       },
                //       icon: CupertinoIcons.minus,
                //       color: Colors.red,
                //     ),
                //     const SizedBox(
                //       width: 5,
                //     ),
                //     Flexible(
                //       flex: 1,
                //       child: TextField(
                //         controller: _quantityTextController,
                //         key: const ValueKey('quantity'),
                //         keyboardType: TextInputType.number,
                //         maxLines: 1,
                //         decoration: const InputDecoration(
                //           border: UnderlineInputBorder(),
                //         ),
                //         textAlign: TextAlign.center,
                //         cursorColor: Colors.green,
                //         enabled: true,
                //         inputFormatters: [
                //           FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                //         ],
                //         onChanged: (value) {
                //           setState(() {
                //             if (value.isEmpty) {
                //               _quantityTextController.text = '1';
                //             } else {}
                //           });
                //         },
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 5,
                //     ),
                //     quantityControl(
                //       fct: () {
                //         setState(() {
                //           _quantityTextController.text =
                //               (int.parse(_quantityTextController.text) + 1)
                //                   .toString();
                //         });
                //       },
                //       icon: CupertinoIcons.plus,
                //       color: Colors.green,
                //     ),
                //   ],
                // ),
                // const Spacer(),
                // Container(
                //   width: double.infinity,
                //   padding:
                //       const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                //   decoration: BoxDecoration(
                //     color: Colors.grey.shade200,
                //     borderRadius: const BorderRadius.only(
                //       topLeft: Radius.circular(20),
                //       topRight: Radius.circular(20),
                //     ),
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Flexible(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             TextWidget(
                //               text: 'Total',
                //               color: Colors.black,
                //               textSize: 20,
                //               isTitle: true,
                //             ),
                //             const SizedBox(
                //               height: 5,
                //             ),
                //             FittedBox(
                //               child: Row(
                //                 children: [
                //                   TextWidget(
                //                     text: '\$${totalPrice.toStringAsFixed(2)}/',
                //                     color: Colors.black,
                //                     textSize: 20,
                //                     isTitle: true,
                //                   ),
                //                   TextWidget(
                //                     text: '${_quantityTextController.text}Kg',
                //                     color: Colors.black,
                //                     textSize: 16,
                //                     isTitle: false,
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       const SizedBox(
                //         width: 8,
                //       ),
                //       Flexible(
                //         child: Material(
                //           color: Colors.lightBlue,
                //           borderRadius: BorderRadius.circular(10),
                //           child: InkWell(
                //             onTap: _isInCart
                //                 ? null
                //                 : () async {
                //                     // if (_isInCart) {
                //                     //   return;
                //                     // }
                //                     final User? user = authInstance.currentUser;
                //                     if (user == null) {
                //                       GlobalMethods.errorDialog(
                //                           subtitle:
                //                               'No user found, Please login first',
                //                           context: context);
                //                       return;
                //                     }
                //                     await GlobalMethods.addToCart(
                //                         productId: getCurrProduct.id,
                //                         quantity: int.parse(
                //                             _quantityTextController.text),
                //                         context: context);
                //                     await cartProvider.fetchCart();
                //                     // cartProvider.addProductsToCart(
                //                     //     productID: getCurrProduct.id,
                //                     //     quantity: int.parse(
                //                     //         _quantityTextController.text));
                //                   },
                //             borderRadius: BorderRadius.circular(10),
                //             child: Padding(
                //                 padding: const EdgeInsets.all(12.0),
                //                 child: TextWidget(
                //                     text: _isInCart ? 'In cart' : 'Add to cart',
                //                     color: Colors.white,
                //                     textSize: 18)),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
