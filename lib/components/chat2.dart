import 'package:flutter/material.dart';

// Size getWidgetSize(GlobalKey globalKey) {
//   RenderBox renderBox =
//       globalKey.currentContext?.findRenderObject() as RenderBox;

//   return renderBox.size;
// }

// class SizedWidget extends StatefulWidget {
//   final GlobalKey globalKey;
//   final Widget child;

//   const SizedWidget({super.key, required this.globalKey, required this.child});

//   @override
//   State<SizedWidget> createState() => _SizedWidgetState();
// }

// class _SizedWidgetState extends State<SizedWidget> {
//   late GlobalKey _globalKey;

//   late Size widgetSize;

//   getWidgetSize() {
//     RenderBox renderBox =
//         _globalKey.currentContext?.findRenderObject() as RenderBox;
//     setState(() {
//       widgetSize = renderBox.size;
//     });
//   }

//   @override
//   void initState() {
//     _globalKey = widget.globalKey;

//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       getWidgetSize();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
