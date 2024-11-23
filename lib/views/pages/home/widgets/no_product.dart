import 'package:flutter/material.dart';

class NoProduct extends StatelessWidget {
  const NoProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/image/dolly-flatbed-alt.png',
                      width: 50,
                      color: Colors.grey[800],
                    ),
                    const Center(
                      child: Text(
                        'no product',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 20),

                  ],
                ),
    );
  }
}