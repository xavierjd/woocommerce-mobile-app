import 'package:flutter/material.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            //_googleSignIn(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: const Color(0xffDADCE0),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/login/g.png'),
                  //fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff1877F2),
              border: Border.all(
                color: const Color(0xffDADCE0),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/login/fb.png'),
                  //fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
