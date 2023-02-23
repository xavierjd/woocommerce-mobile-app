import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:woo_store/screens/auth/orders_screen.dart';
import 'package:woo_store/services/shared_services.dart';

import 'package:woo_store/services/utils.dart';
import 'package:woo_store/widgets/appbar_widget.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/widgets/unauth_widget.dart';
import 'package:woo_store/woocommerce/models/login_model.dart';
import 'auth/login_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class OptionList {
  String optionTitle;
  String optionSubTitle;
  IconData optionIcon;
  Function opTap;

  OptionList({
    required this.optionIcon,
    required this.optionTitle,
    required this.optionSubTitle,
    required this.opTap,
  });
}

class _UserScreenState extends State<UserScreen> {
  List<OptionList> options = [];

  @override
  void initState() {
    super.initState();

    options.addAll([
      OptionList(
        optionIcon: Icons.shopping_cart,
        optionTitle: 'Orders',
        optionSubTitle: 'Check my orders',
        opTap: () {
          Navigator.pushNamed(
            context,
            OrdersScreen.routeName,
          );
        },
      ),
      OptionList(
        optionIcon: Icons.edit,
        optionTitle: 'Edit Profile',
        optionSubTitle: 'Update your profile',
        opTap: () {
          // Navigator.pushNamed(
          //   context,
          //   OrdersScreen.routeName,
          // );
        },
      ),
      OptionList(
        optionIcon: Icons.notifications,
        optionTitle: 'Notifications',
        optionSubTitle: 'Check the lastest notifications',
        opTap: () {
          // Navigator.pushNamed(
          //   context,
          //   OrdersScreen.routeName,
          // );
        },
      ),
      OptionList(
        optionIcon: Icons.power_settings_new,
        optionTitle: 'Sign Out',
        optionSubTitle: 'Check the lastest notifications',
        opTap: () {
          SharedService.logout().then((value) => {setState(() {})});
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    //Size screenSize = Utils(context).getScreenSize;
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'User Details',
        backgroundColor: Colors.pinkAccent,
      ),
      body: FutureBuilder(
        future: SharedService.isLoggedIn(),
        builder: (
          BuildContext context,
          AsyncSnapshot<bool> loginModel,
        ) {
          if (loginModel.hasData) {
            if (loginModel.data!) {
              return _listView(context);
            } else {
              return const UnAuthWidget();
            }
          }
          return const UnAuthWidget();
        },
      ),
    );

    // SingleChildScrollView(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       _userHeader(
    //         screenSize: screenSize,
    //       ),
    //       SizedBox(
    //         height: screenSize.height / 50,
    //       ),
    //       _listTiles(
    //         title: 'Pedidos',
    //         icon: IconlyLight.bag,
    //         onPressed: () {},
    //       ),
    //       _listTiles(
    //         title: 'Olvide contraseña',
    //         icon: IconlyLight.unlock,
    //         onPressed: () {},
    //       ),
    //       _listTiles(
    //         title: 'Iniciar sesión',
    //         icon: IconlyLight.login,
    //         onPressed: () {
    //           Navigator.pushNamed(
    //             context,
    //             LoginScreen.routeName,
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // ),
  }

  Widget _buildRow(OptionList optionList, int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          child: Icon(
            optionList.optionIcon,
            size: 30,
          ),
        ),
        onTap: () {
          optionList.opTap();
        },
        title: Text(
          optionList.optionTitle,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            optionList.optionSubTitle,
            style: const TextStyle(
              color: Colors.redAccent,
              fontSize: 14,
            ),
          ),
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
      ),
    );
  }

  Widget _listView(BuildContext context) {
    return FutureBuilder(
      future: SharedService.loginDetails(),
      builder: (BuildContext context,
          AsyncSnapshot<LoginResponseModel?> loginModel) {
        if (loginModel.hasData) {
          return ListView(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome, ${loginModel.data!.data!.displayName}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                itemCount: options.length,
                physics: const ScrollPhysics(),
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: _buildRow(options[index], index),
                  );
                },
              )
            ],
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  // Widget _userHeader({required Size screenSize}) {
  //   return Container(
  //     height: screenSize.height / 8,
  //     width: screenSize.width,
  //     color: Colors.pinkAccent,
  //     // alignment: Alignment.center,
  //     padding: EdgeInsets.all(screenSize.width / 20),
  //     child: Row(
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
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             TextWidget(
  //               text: '!Hola Xavier!',
  //               color: Colors.white,
  //               textSize: 20,
  //             ),
  //             TextWidget(
  //                 text: 'xjacintod@gmail.com',
  //                 color: Colors.white,
  //                 textSize: 12),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _listTiles({
  //   required String title,
  //   required IconData icon,
  //   required Function onPressed,
  // }) {
  //   return ListTile(
  //     title: Text(title),
  //     leading: Icon(icon),
  //     trailing: const Icon(IconlyLight.arrowRight2),
  //     onTap: () {
  //       onPressed();
  //     },
  //   );
  // }
}
