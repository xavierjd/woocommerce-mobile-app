import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:woo_store/services/utils.dart';
import 'package:woo_store/woocommerce/models/product_model.dart';

class ProductDetailsWidget extends StatelessWidget {
  ProductDetailsWidget({super.key, required this.data});

  final ProductModel data;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Stack(
          children: [
            _productImages(data.images!, context),
          ],
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
                Icons.arrow_back_ios,
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
                Icons.arrow_forward_ios,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
