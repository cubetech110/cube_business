import 'package:cube_business/core/helper/nav_helper.dart';
import 'package:cube_business/views/pages/add_product/add_product.dart';
import 'package:cube_business/views/widgets/custom_b.dart';
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
                        'لا توجد منتجات',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 20),

                  ],
                ),
    );
  }
}