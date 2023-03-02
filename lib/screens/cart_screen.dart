import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:woo_store/inner_screens/verify_address_screen.dart';
import 'package:woo_store/services/shared_services.dart';
import 'package:woo_store/services/utils.dart';
import 'package:woo_store/widgets/appbar_widget.dart';
import 'package:woo_store/widgets/cart_product_widget.dart';
import 'package:woo_store/widgets/empty_screen_widget.dart';
import 'package:woo_store/widgets/loading_widget.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/widgets/unauth_widget.dart';
import 'package:woo_store/woocommerce/provider/cart_provider.dart';
import 'package:woo_store/woocommerce/provider/loader_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 1),
      () async {
        final loadingProvider =
            Provider.of<LoaderProvider>(context, listen: false);
        final cartItemsProvider =
            Provider.of<CartProvider>(context, listen: false);
        loadingProvider.setLoadingStatus(true);
        await cartItemsProvider.fetchCartItem();
        loadingProvider.setLoadingStatus(false);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loadingProvider = Provider.of<LoaderProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList = cartProvider.getCartItems;
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Carrito',
        backgroundColor: Colors.pinkAccent,
      ),
      body: FutureBuilder(
        future: SharedService.isLoggedIn(),
        builder: (BuildContext contex, AsyncSnapshot<bool> loginModel) {
          if (loginModel.hasData) {
            if (loginModel.data!) {
              return LoadingWidget(
                isLoading: loadingProvider.isApiCallProcess,
                child: cartItemsList.isEmpty
                    ? const EmptyScreen(
                        icon: FontAwesomeIcons.cartShopping,
                        title: 'Tu carrito esta vacio 🙁',
                        subtitle: 'Agrega productos ',
                        buttonText: 'Ver productos')
                    : _cartItemList(cartProvider),
              );
            } else {
              return const UnAuthWidget();
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _cartItemList(CartProvider cartProvider) {
    Size screenSize = Utils(context).getScreenSize;
    final cartItemsList = cartProvider.getCartItems;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: cartItemsList.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: cartItemsList[index],
                  child: const CartProductWidget(),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.lightBlue,
                  ),
                  onPressed: () async {
                    final loadingProvider =
                        Provider.of<LoaderProvider>(context, listen: false);

                    loadingProvider.setLoadingStatus(true);
                    await cartProvider.updateCart();
                    loadingProvider.setLoadingStatus(false);
                  },
                  icon: const Icon(
                    Icons.sync,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Actualizar',
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          color: Colors.white,
          width: screenSize.width,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: 'Total',
                      color: Colors.black,
                      textSize: 18,
                      isTitle: false,
                    ),
                    TextWidget(
                      text: '\$ ${cartProvider.totalAmount.toStringAsFixed(2)}',
                      color: Colors.black,
                      textSize: 18,
                      isTitle: true,
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      VerifyAddressScreen.routeName,
                    );
                  },
                  icon: const Icon(
                    Icons.credit_card,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Proceder al Pago',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
