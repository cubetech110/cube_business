import 'package:flutter/material.dart';

class PromotionPage extends StatelessWidget {
  const PromotionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Store Promotion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Try to load the promotion image. If it fails, show a promotion icon.
            Image.asset(
              'assets/promotion_image.png',
              height: 200,
              width: 400,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return Icon(
                  Icons.local_offer, // Promotion icon if the image is missing
                  size: 100,
                  color: Colors.redAccent,
                );
              },
            ),
            const SizedBox(height: 20),
            // Promotion text
            const Text(
              'Limited Time Offer!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Get 30% off on all items. Hurry up!',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
