import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:woo_store/screens/cart_screen.dart';
import 'package:woo_store/screens/wishlist_screen.dart';
import 'package:woo_store/screens/home_screen.dart';
import 'package:woo_store/screens/notifications_screen.dart';
import 'package:woo_store/screens/user_screen.dart';
import 'package:woo_store/woocommerce/provider/cart_provider.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = 'home';
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _pages = [
    {'page': const HomeScreen(), 'title': 'Home Screen'},
    {'page': const WishListScreen(), 'title': 'WishList Screen'},
    {'page': const CartScreen(), 'title': 'Cart Screen'},
    //{'page': const OrdersScreen(), 'title': 'OrdersScreen'},
    {'page': const NotificationsScreen(), 'title': 'Notification Screen'},
    {'page': const UserScreen(), 'title': 'User Screen'}
  ];
  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _selectedPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 1 ? IconlyBold.heart : IconlyLight.heart,
            ),
            label: "WishList",
          ),
          BottomNavigationBarItem(
            //icon: Icon(IconlyBold.buy),
            icon: Consumer<CartProvider>(
              builder: (_, myCart, ch) {
                return badge.Badge(
                  badgeAnimation: const badge.BadgeAnimation.slide(),
                  badgeStyle: badge.BadgeStyle(
                    shape: badge.BadgeShape.circle,
                    badgeColor: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  position: badge.BadgePosition.topEnd(top: -14, end: -14),
                  badgeContent: FittedBox(
                    child: FittedBox(
                      child: Text(myCart.getCartItems.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                          )),
                    ),
                  ),
                  child: Icon(
                    _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy,
                  ),
                );
              },
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 3
                  ? IconlyBold.notification
                  : IconlyLight.notification,
            ),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 4 ? IconlyBold.user_2 : IconlyLight.user,
            ),
            label: "User",
          ),
        ],
      ),
    );
  }
}
