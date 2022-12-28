import 'package:flutter/material.dart';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

import 'package:provider/provider.dart';
import 'package:woo_store/services/utils.dart';
import 'package:woo_store/woocommerce/models/product_model.dart';

class FeedItemWidget extends StatefulWidget {
  const FeedItemWidget({super.key});

  @override
  State<FeedItemWidget> createState() => _FeedItemWidgetState();
}

class _FeedItemWidgetState extends State<FeedItemWidget> {
  @override
  Widget build(BuildContext context) {
    Size sizeScreen = Utils(context).getSizeScreen();
    final productModel = Provider.of<ProductModel>(context);
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: () {},
        child: Column(children: [
          FancyShimmerImage(
            imageUrl: productModel.images!.first.src,
            height: sizeScreen.width * 0.22,
            width: sizeScreen.width * 0.22,
            boxFit: BoxFit.fill,
          ),
        ]),
      ),
    );
  }
}
