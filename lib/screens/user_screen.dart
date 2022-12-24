import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:woo_store/services/utils.dart';
import 'package:woo_store/widgets/text_widget.dart';
import 'auth/login_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils(context).getSizeScreen();
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            _userHeader(
              screenSize: screenSize,
            ),
            SizedBox(
              height: screenSize.height / 50,
            ),
            _listTiles(
              title: 'Pedidos',
              icon: IconlyLight.bag,
              onPressed: () {},
            ),
            _listTiles(
              title: 'Olvide contraseña',
              icon: IconlyLight.unlock,
              onPressed: () {},
            ),
            _listTiles(
              title: 'Iniciar sesión',
              icon: IconlyLight.login,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
            )
          ])),
    );
  }

  Widget _userHeader({required Size screenSize}) {
    return Container(
      height: screenSize.height / 8,
      width: screenSize.width,
      color: Colors.pinkAccent,
      // alignment: Alignment.center,
      padding: EdgeInsets.all(screenSize.width / 20),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFD6D6D6),
            child: Icon(
              FontAwesomeIcons.user,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 18,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: '!Hola Xavier!',
                color: Colors.white,
                textSize: 20,
              ),
              TextWidget(
                  text: 'xjacintod@gmail.com',
                  color: Colors.white,
                  textSize: 12),
            ],
          ),
        ],
      ),
    );
  }

  Widget _listTiles({
    required String title,
    required IconData icon,
    required Function onPressed,
  }) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
