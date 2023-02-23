import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:woo_store/widgets/appbar_widget.dart';
import 'package:woo_store/widgets/categories_home_widget.dart';
import 'package:woo_store/widgets/products_home_widget.dart';

import '../services/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _offresImg = [
    'https://bitfun.mx/wp-content/uploads/2023/01/roblox_categoria.jpg',
    'https://bitfun.mx/wp-content/uploads/2023/01/league-of-legends-categoria.jpg',
    'https://bitfun.mx/wp-content/uploads/2023/01/crunchyroll-categoria.jpg',
    'https://bitfun.mx/wp-content/uploads/2023/01/xbox-categoria.jpg',
    'https://bitfun.mx/wp-content/uploads/2023/01/minecraft-categoria.jpg',
    'https://bitfun.mx/wp-content/uploads/2023/01/nintendo-categoria.jpg',
    'https://bitfun.mx/wp-content/uploads/2023/01/razer-gold-categoria.jpg',
    'https://bitfun.mx/wp-content/uploads/2023/01/playstation-categoria.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
          title: 'Home Screen', backgroundColor: Colors.pinkAccent),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            imageSwiper(context),
            const CategoriesHomeWidget(),
            const ProductsHomeWidget(labelName: 'Best Selling'),
            const ProductsHomeWidget(labelName: 'Trending'),
          ],
        ),
      ),
    );
  }

  Widget imageSwiper(BuildContext context) {
    Size screenSize = Utils(context).getScreenSize;
    return SizedBox(
      width: screenSize.width,
      height: 400,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            _offresImg[index],
            fit: BoxFit.fill,
          );
          // return Image.asset(
          //   _offresImg[index],
          //   fit: BoxFit.fill,
          // );
        },
        autoplay: false,
        itemCount: _offresImg.length,
        viewportFraction: 0.8,
        scale: 0.9,
        pagination: const SwiperPagination(
            alignment: Alignment.bottomCenter,
            builder: DotSwiperPaginationBuilder(
                color: Colors.white, activeColor: Colors.lightBlue)),
      ),
    );
  }

  // Widget _homeHeader({required Size screenSize}) {
  //   return Container(
  //     height: screenSize.height / 8,
  //     width: screenSize.width,
  //     color: Colors.pinkAccent,
  //     alignment: Alignment.center,
  //     padding: EdgeInsets.all(screenSize.width / 20),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         const CircleAvatar(
  //           backgroundColor: Color(0xFFD6D6D6),
  //           child: Icon(
  //             FontAwesomeIcons.user,
  //             color: Colors.white,
  //           ),
  //         ),
  //         const SizedBox(
  //           width: 18,
  //         ),
  //         TextWidget(
  //           text: '!Bienvendio!',
  //           color: Colors.white,
  //           textSize: 20,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
