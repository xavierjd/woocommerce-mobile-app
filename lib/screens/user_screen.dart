import 'package:flutter/material.dart';

import 'package:woo_store/screens/auth/orders_screen.dart';
import 'package:woo_store/screens/bottom_bar_screen.dart';
import 'package:woo_store/services/global_methods.dart';
import 'package:woo_store/services/shared_services.dart';
import 'package:woo_store/widgets/appbar_widget.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'package:woo_store/widgets/unauth_widget.dart';
import 'package:woo_store/woocommerce/models/customer_detail_model.dart';
import 'package:woo_store/woocommerce/woocommerce_const.dart';

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
        opTap: () {},
      ),
      OptionList(
        optionIcon: Icons.power_settings_new,
        optionTitle: 'Sign Out',
        optionSubTitle: 'Check the lastest notifications',
        opTap: () async {
          await GlobalMethods.warningDialog(
            title: 'Log Out',
            subtitle: '¿Are you sure you want to log out?',
            fct: () async {
              await SharedService.logout();
              // ignore: use_build_context_synchronously
              Navigator.pushNamedAndRemoveUntil(
                context,
                BottomBarScreen.routeName,
                (route) => false,
              );
            },
            context: context,
          );
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
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
          if (loginModel.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (loginModel.data!) {
              return _listView(context);
            } else {
              return const UnAuthWidget();
            }
          }
        },
      ),
    );
  }

  Widget _listView(BuildContext context) {
    return FutureBuilder(
      future: apiWoocommerce.customerDetails(),
      builder: (BuildContext context,
          AsyncSnapshot<CustomerDetailsModel?> customerData) {
        if (customerData.hasData) {
          return ListView(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(15, 15, 0, 0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFFD6D6D6),
                      backgroundImage: customerData.data!.profilePicture != null
                          ? NetworkImage(
                              customerData.data!.profilePicture.value)
                          : NetworkImage(customerData.data!.avatarUrl),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Hola, ${customerData.data!.firstName}',
                          color: Colors.black,
                          isTitle: true,
                          textSize: 22,
                        ),
                        TextWidget(
                          text: customerData.data!.email,
                          color: Colors.grey,
                          isTitle: false,
                          textSize: 15,
                        ),
                      ],
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
}
