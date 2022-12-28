import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woo_store/fetch_screen.dart';
import 'package:woo_store/inner_screens/category_inner_screen.dart';
import 'package:woo_store/woo_provider/categories_provider.dart';
import 'package:woo_store/woo_provider/products_provider.dart';

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
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: const FetchScreen(),
        routes: {
          CategoryInnerScreen.routeName: (context) =>
              const CategoryInnerScreen()
        },
      ),
    );
  }
}
