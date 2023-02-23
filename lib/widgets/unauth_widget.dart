import 'package:flutter/material.dart';

import 'package:woo_store/screens/auth/login_screen.dart';
import 'package:woo_store/widgets/appbar_widget.dart';
import 'package:woo_store/widgets/text_widget.dart';

class UnAuthWidget extends StatefulWidget {
  const UnAuthWidget({super.key});

  @override
  State<UnAuthWidget> createState() => _UnAuthWidgetState();
}

class _UnAuthWidgetState extends State<UnAuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: '', backgroundColor: Colors.pinkAccent),
      body: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Stack(
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Colors.green.withOpacity(1),
                          Colors.green.withOpacity(0.2),
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.lock,
                      color: Colors.white,
                      size: 90,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Opacity(
                opacity: 0.6,
                child: Text(
                  'You must sign-in to access to this section',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    LoginScreen.routeName,
                  );
                },
                child: TextWidget(
                  text: 'Login',
                  textSize: 18,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
