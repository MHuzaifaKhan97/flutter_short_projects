import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  const AppBackground({
    Key? key,
    required this.child,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.blue,
          Colors.blue,
          Colors.lightBlue,
          Colors.lightBlue,
          Colors.lightBlue,
          Colors.lightBlue,
          Colors.blueAccent,
          Colors.lightBlue,
          Colors.blue,
        ], end: Alignment.centerLeft, begin: Alignment.bottomRight),
      ),
      child: SafeArea(
        bottom: false,
        child: child,
      ),
    );
  }
}
