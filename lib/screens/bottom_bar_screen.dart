import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:woo_store/screens/cart_screen.dart';
import 'package:woo_store/screens/categories_screen.dart';
import 'package:woo_store/screens/home_screen.dart';
import 'package:woo_store/screens/notifications_screen.dart';
import 'package:woo_store/screens/user_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _pages = [
    {'page': const HomeScreen(), 'title': 'Home Screen'},
    {'page': const CategoriesScreen(), 'title': 'Category Screen'},
    {'page': const CartScreen(), 'title': 'Cart Screen'},
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
      // appBar: AppBar(
      //   title: Text(_pages[_selectedIndex]['title']),
      //   centerTitle: true,
      // ),
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
              _selectedIndex == 1 ? IconlyBold.category : IconlyLight.category,
            ),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Badge(
              toAnimate: true,
              shape: BadgeShape.circle,
              badgeColor: Colors.blue,
              borderRadius: BorderRadius.circular(8),
              position: BadgePosition.topEnd(top: -14, end: -14),
              badgeContent: const FittedBox(
                child: Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              child: Icon(
                _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy,
              ),
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
