// import 'package:flutter/material.dart';

// class ProgressHUD extends StatelessWidget {
//   const ProgressHUD({
//     super.key,
//     required this.child,
//     required this.inAsyncCall,
//     required this.opacity,
//     required this.color,
//   });

//   final Widget child;
//   final bool inAsyncCall;
//   final double opacity;
//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> widgetList = [];
//     widgetList.add(child);
//     if (inAsyncCall) {
//       final modal = Stack(
//         children: [
//           Opacity(
//             opacity: opacity,
//             child: ModalBarrier(dismissible: false, color: color),
//           ),
//           const Center(
//             child: CircularProgressIndicator(),
//           ),
//         ],
//       );
//       widgetList.add(modal);
//     }
//     return Stack(
//       children: widgetList,
//     );
//   }
// }
