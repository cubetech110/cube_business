import 'dart:ui';
import 'package:flutter/material.dart';

class MyBackground extends StatelessWidget {
  final Widget child;

  const MyBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // الدائرة الزرقاء في الخلفية
        Positioned(
          top: -50,
          left: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.withOpacity(0.3),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        // الدائرة الوردية في الخلفية
        Positioned(
          bottom: -50,
          right: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.pink.withOpacity(0.3),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        // المحتوى الرئيسي
        child,
      ],
    );
  }
}
