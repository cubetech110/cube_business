import 'package:cube_business/views/pages/add_product/add_product.dart';
import 'package:cube_business/views/pages/chart/product_chart.dart';
import 'package:cube_business/views/pages/home/widgets/item.dart';
import 'package:cube_business/views/pages/products/product_list_screen.dart';
import 'package:cube_business/views/widgets/items.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Statistics'),),
      body: ListView(
        children: [
          ProductSalesChart(),
          ItemsRow(
            items: [
              Items(
                title: 'Vist',
                value: '20',
                percentage: '+0.5',
                progressValue: 0.12,
                progressColor: Colors.green,
                backgroundColor: Colors.white,
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(builder: (_) => ProductsListScreen()));
                },
              ),
              Items(
                title: 'Rate',
                value: '4.5',
                percentage: '+0.5',
                backgroundColor: Colors.white,
                progressColor: const Color.fromARGB(255, 185, 167, 3),
                progressValue: 0.12,
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(builder: (_) => ProductsListScreen()));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
