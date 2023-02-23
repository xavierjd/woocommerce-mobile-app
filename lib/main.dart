import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_store/fetch_screen.dart';
import 'package:woo_store/inner_screens/order_details_screen.dart';
import 'package:woo_store/inner_screens/order_success_screen.dart';
import 'package:woo_store/inner_screens/paypal_payment_screen.dart';
import 'package:woo_store/inner_screens/product_list_screen.dart';
import 'package:woo_store/inner_screens/payment_screen.dart';
import 'package:woo_store/inner_screens/product_details_screen.dart';
import 'package:woo_store/inner_screens/verify_address_screen.dart';
import 'package:woo_store/screens/auth/login_screen.dart';
import 'package:woo_store/screens/auth/orders_screen.dart';
import 'package:woo_store/screens/bottom_bar_screen.dart';
import 'package:woo_store/screens/home_screen.dart';
import 'package:woo_store/woo_provider/categories_provider.dart';
import 'package:woo_store/woocommerce/provider/cart_provider.dart';
import 'package:woo_store/woocommerce/provider/customer_details_provider.dart';
import 'package:woo_store/woocommerce/provider/order_provider.dart';
import 'package:woo_store/woocommerce/provider/product_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => CustomerDetailsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Rubik'),
        title: 'Flutter Demo',
        home: const FetchScreen(),
        routes: {
          BottomBarScreen.routeName: (context) => const BottomBarScreen(),
          LoginScreen.routeName: (context) => const LoginScreen(),
          ProductListScreen.routeName: (context) => const ProductListScreen(),
          ProductDetailsScreen.routeName: (context) =>
              const ProductDetailsScreen(),
          PaymentScreen.routeName: (context) => const PaymentScreen(),
          VerifyAddressScreen.routeName: (context) =>
              const VerifyAddressScreen(),
          PaypalPaymentScreen.routeName: (context) =>
              const PaypalPaymentScreen(),
          OrderSuccessScreen.routeName: (context) => const OrderSuccessScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen(),
          OrderDetailsScreen.routeName: (context) => const OrderDetailsScreen(),
        },
      ),
    );
  }
}
