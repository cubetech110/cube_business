import 'package:cube_business/core/helper/nav_helper.dart';
import 'package:cube_business/views/pages/payment/pay.dart';
import 'package:flutter/material.dart';



class PricingCard extends StatelessWidget {
  const PricingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Card(
            color: const Color.fromARGB(255, 0, 0, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Business plan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),

                        ],
                      ),

                    ],
                  ),
                  const SizedBox(height: 16),
                  // Price
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      children: [
                        TextSpan(
                          text: '\$20 ',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'per user\n',
                        ),
                        TextSpan(text: 'per month'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {

navigateTo(context, PayScreen());

                          },
                          child: const Text('Get started'),
                        ),
                      ),
                      const SizedBox(width: 8),

                    ],
                  ),
                  const SizedBox(height: 16),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(String feature) {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: Color(0xFF2ACC74), size: 20),
        const SizedBox(width: 8),
        Text(
          feature,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}
