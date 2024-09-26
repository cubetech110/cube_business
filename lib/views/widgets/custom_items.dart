import 'package:flutter/material.dart';

class CustomItems extends StatelessWidget {
  final String title;
  final String value;
  final String percentage;
  final Color backgroundColor;
  final Color progressColor;
  final double progressValue;
  final VoidCallback onTap; // Callback for tap event

  const CustomItems({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.backgroundColor,
    required this.progressColor,
    required this.progressValue,
    required this.onTap, // Add the onTap callback
  });

  @override
  Widget build(BuildContext context) {
    // Determine text color based on background color brightness
    final bool isDarkBackground =
        ThemeData.estimateBrightnessForColor(backgroundColor) ==
            Brightness.dark;
    final Color textColor = isDarkBackground ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: onTap, // Add the onTap event to GestureDetector
      child: Container(
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
            Text(
              value,
              style: TextStyle(
                color: textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  percentage,
                  style: TextStyle(
                    color: Colors.green[300],
                    fontSize: 16,
                  ),
                ),
                CircularProgressIndicator(
                  value: progressValue,
                  color: progressColor,
                  backgroundColor: Colors.white.withOpacity(0.2),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

