import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_store/widgets/stepper_widget.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/woocommerce/models/cart_reponse_model.dart';
import 'package:woo_store/woocommerce/provider/cart_provider.dart';

class CartProductWidget extends StatelessWidget {
  const CartProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<CartItem>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          leading: Container(
            width: 50,
            height: 150,
            alignment: Alignment.center,
            child: FancyShimmerImage(
              imageUrl: data.thumbnail.isNotEmpty
                  ? data.thumbnail
                  : 'https://bitfun.mx/wp-content/uploads/woocommerce-placeholder.png',
              boxFit: BoxFit.fill,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.all(5),
            child: TextWidget(
              text: data.productName,
              color: Colors.black,
              textSize: 18,
              isTitle: true,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(5),
            child: Wrap(
              direction: Axis.vertical,
              children: [
                TextWidget(
                  text: "\$ ${data.productRegularPrice}",
                  color: Colors.black,
                  textSize: 15,
                ),
                TextButton.icon(
                  onPressed: () {
                    cartProvider.removeItem(productId: data.productId);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.lightBlue,
                  ),
                  icon: const Icon(
                    Icons.delete,
                  ),
                  label: const Text(
                    'Elminiar',
                  ),
                ),
              ],
            ),
          ),
          trailing: SizedBox(
            width: 120,
            child: StepperWidget(
              lowerLimit: 1,
              upperLimit: data.qty,
              stepValue: 1,
              value: data.qty,
              onChanged: (value) {
                cartProvider.updateQty(
                  productId: data.productId,
                  qty: value,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
