import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:woo_store/services/utils.dart';
import 'package:woo_store/widgets/appbar_widget.dart';
import 'package:woo_store/widgets/expand_text_widget.dart';
import 'package:woo_store/widgets/related_product_widget.dart';
import 'package:woo_store/widgets/stepper_widget.dart';
import 'package:woo_store/widgets/text_widget.dart';

import '../woocommerce/models/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = '/ProductDetails';
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as ProductModel;
    double usedPrice = data.isOnSale ? data.salePrice : data.price;
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Product Details',
        backgroundColor: Colors.pinkAccent,
      ),
      // appBar: AppBar(
      //     leading: InkWell(
      //       borderRadius: BorderRadius.circular(12),
      //       onTap: () =>
      //           Navigator.canPop(context) ? Navigator.pop(context) : null,
      //       child: const Icon(
      //         IconlyLight.arrowLeft2,
      //         color: Colors.black,
      //         size: 24,
      //       ),
      //     ),
      //     elevation: 0,
      //     backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _productImages(data.images!, context),
                  Visibility(
                    visible: data.isOnSale ? true : false,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextWidget(
                          text: '${data.calcuatedDiscount()} %OFF',
                          color: Colors.white,
                          textSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextWidget(
                    text: data.name,
                    color: Colors.black,
                    textSize: 18,
                    isTitle: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        visible: data.isOnSale ? true : false,
                        child: Text(
                          '\$${data.salePrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StepperWidget(
                        lowerLimit: 0,
                        upperLimit: 20,
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
                  const SizedBox(
                    height: 5,
                  ),
                  ExpandTextWidget(
                    labelHeader: 'Product Details',
                    desc: data.description,
                    shortDesc: data.shortDescription,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  RelatedProductsWidget(
                      labelName: 'Productos relacionados',
                      products: data.relatedIds),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productImages(List<Img> images, BuildContext context) {
    Size screenSize = Utils(context).getScreenSize;
    return SizedBox(
      width: screenSize.width,
      height: screenSize.width * 0.5,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  child: Center(
                    child: Image.network(
                      images[index].src,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 1,
                aspectRatio: 1,
              ),
              carouselController: _controller,
            ),
          ),
          Positioned(
            top: 100,
            left: screenSize.width - 80,
            child: IconButton(
              onPressed: () {
                _controller.previousPage();
              },
              icon: const Icon(
                Icons.arrow_forward_ios,
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: IconButton(
              onPressed: () {
                _controller.nextPage();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
