import 'package:flutter/material.dart';

class Items extends StatelessWidget {
  final String title;
  final String value; // No longer nullable
  final String? percentage;
  final Color backgroundColor;
  final Color? progressColor;
  final double? progressValue;
  final VoidCallback onTap;
  final Widget? icon;

  const Items({
    super.key,
    required this.title,
    required this.value, // Required since it will always have a default value
    this.percentage,
    required this.backgroundColor,
    this.progressColor,
    this.progressValue,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkBackground =
        ThemeData.estimateBrightnessForColor(backgroundColor) ==
            Brightness.dark;
    final Color textColor = isDarkBackground ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200, // Set a fixed height for all cards
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: textColor.withOpacity(0.7), fontSize: 16),
            ),
            const SizedBox(height: 8),
            if (icon == null)
              Text(
                value,
                style: TextStyle(
                  color: textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              )
            else
              const SizedBox(),
            const SizedBox(height: 16),
            if (icon != null)
              Align(
                alignment: Alignment.centerRight,
                child: icon!,
              )
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(
                  //   percentage!,
                  //   style: TextStyle(
                  //     color: progressColor,
                  //     fontSize: 16,
                  //   ),
                  // ),

                ],
              ),
          ],
        ),
      ),
    );
  }
}
