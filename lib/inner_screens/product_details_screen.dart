import 'package:carousel_slider/carousel_slider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_store/services/utils.dart';
import 'package:woo_store/widgets/appbar_widget.dart';
import 'package:woo_store/widgets/expand_text_widget.dart';
import 'package:woo_store/widgets/loading_widget.dart';
import 'package:woo_store/widgets/related_product_widget.dart';
import 'package:woo_store/widgets/stepper_widget.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/woocommerce/models/cart_request_model.dart';
import 'package:woo_store/woocommerce/provider/cart_provider.dart';
import 'package:woo_store/woocommerce/provider/loader_provider.dart';

import '../woocommerce/models/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = '/ProductDetails';
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int initQty = 1;
  late int quantity = 1;

  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as ProductModel;
    final cartProvider = Provider.of<CartProvider>(context);

    final loadingProvider = Provider.of<LoaderProvider>(context);

    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Product Details',
        backgroundColor: Colors.pinkAccent,
      ),
      body: LoadingWidget(
        isLoading: loadingProvider.isApiCallProcess,
        child: SingleChildScrollView(
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
                          text: '\$${data.price.toStringAsFixed(2)} MXN',
                          color: Colors.green,
                          textSize: 22,
                          isTitle: true,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Visibility(
                          visible: data.isOnSale,
                          child: Text(
                            '\$${data.regularPrice.toStringAsFixed(2)} MXN',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    data.stockStatus == 'outofstock'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: 'Agotado',
                                color: Colors.red,
                                textSize: 18,
                                isTitle: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton.icon(
                                icon: const Icon(Icons.email_outlined),
                                label: const Text('Notificarme existencias'),
                                onPressed: () {
                                  _showBackInStockDialog();
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.only(
                                    left: 0,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: 'Disponibilidad: ${data.stockQty}',
                                color: Colors.black,
                                textSize: 18,
                                isTitle: true,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  StepperWidget(
                                    lowerLimit: 1,
                                    upperLimit: data.stockQty,
                                    stepValue: 1,
                                    value: initQty,
                                    onChanged: (value) {
                                      quantity = value;
                                    },
                                  ),
                                  ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(140, 50),
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.lightBlue,
                                    ),
                                    icon: const Icon(
                                      Icons.shopping_cart_rounded,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      'Agregar',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () async {
                                      final loadingStatusProvider =
                                          Provider.of<LoaderProvider>(context,
                                              listen: false);
                                      loadingStatusProvider
                                          .setLoadingStatus(true);

                                      await cartProvider.addToCart(
                                        product: CartProducts(
                                          productId: data.id,
                                          quantity: quantity,
                                        ),
                                      );

                                      loadingStatusProvider
                                          .setLoadingStatus(false);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    ExpandTextWidget(
                      labelHeader: 'Detalles del Producto',
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
      ),
    );
  }

  Future<void> _showBackInStockDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: TextWidget(
              text: 'Notifíquenme',
              color: Colors.black,
              textSize: 18,
              isTitle: true,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidget(
                text:
                    'Si tu producto vuelve a estar disponible, te enviaremos un correo electrónico.',
                color: Colors.black,
                textSize: 15,
              ),
              const SizedBox(
                height: 10,
              ),
              TextWidget(
                text: 'Te notificaremos en:',
                color: Colors.black,
                textSize: 15,
                isTitle: true,
              ),
              const SizedBox(
                height: 10,
              ),
              TextWidget(
                text: 'bitfunmx@gmail.com',
                color: Colors.black,
                textSize: 15,
              ),
            ],
          ),
          actions: [
            Center(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Notificar'),
              ),
            ),
          ],
        );
      },
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
                return Center(
                  child: FancyShimmerImage(
                    imageUrl: images[index].src.isNotEmpty
                        ? images[index].src
                        : 'https://bitfun.mx/wp-content/uploads/woocommerce-placeholder.png',
                    boxFit: BoxFit.fill,
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
