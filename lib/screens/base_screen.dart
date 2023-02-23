// import 'package:flutter/material.dart';
// import 'package:woo_store/Utils/ProgressHUD.dart';
// import 'package:woo_store/widgets/appbar_widget.dart';

// class BaseScreen extends StatefulWidget {
//   const BaseScreen({super.key});

//   @override
//   State<StatefulWidget> createState() => BaseScreenState<BaseScreen>();
// }

// class BaseScreenState<T extends StatefulWidget> extends State<T> {
//   bool isApiCallProcess = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBarWidget(title: 'dd', backgroundColor: Colors.white),
//         body: ProgressHUD(
//           child: pageUI(),
//           inAsyncCall: isApiCallProcess,
//           opacity: 0.5,
//           color: Colors.black,
//         ));
//   }

//   Widget? pageUI() {
//     return null;
//   }
// }
