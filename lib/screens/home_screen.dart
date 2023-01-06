import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/utils.dart';
import '../widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils(context).getScreenSize;
    return Scaffold(
      body: Column(
        children: [
          _homeHeader(screenSize: screenSize),
          const Expanded(
            child: Center(
              child: Text('Home Screen'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _homeHeader({required Size screenSize}) {
    return Container(
      height: screenSize.height / 8,
      width: screenSize.width,
      color: Colors.pinkAccent,
      alignment: Alignment.center,
      padding: EdgeInsets.all(screenSize.width / 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
          TextWidget(
            text: '!Bienvendio!',
            color: Colors.white,
            textSize: 20,
          ),
        ],
      ),
    );
  }
}
