import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyBackground extends StatefulWidget {
  final Widget child;

  const MyBackground({super.key, required this.child});

  @override
  _MyBackgroundState createState() => _MyBackgroundState();
}

class _MyBackgroundState extends State<MyBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // الدائرة الزرقاء في الخلفية
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            double animatedX = 50 * math.sin(_controller.value * 2 * math.pi);
            double animatedY = 50 * math.cos(_controller.value * 2 * math.pi);
            return Positioned(
              top: -50 + animatedY,
              left: -50 + animatedX,
              child: Container(
                width: 250,
                height: 250,
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
            );
          },
        ),
        // الدائرة الوردية في الخلفية
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            double animatedX = 50 * math.cos(_controller.value * 2 * math.pi);
            double animatedY = 50 * math.sin(_controller.value * 2 * math.pi);
            return Positioned(
              bottom: -50 + animatedY,
              right: -50 + animatedX,
              child: Container(
                width: 250,
                height: 250,
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
            );
          },
        ),
        // المحتوى الرئيسي
        widget.child,
      ],
    );
  }
}
