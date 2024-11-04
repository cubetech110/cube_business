import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProductSalesChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Example product sales data
    final List<SalesData> salesData = [
      SalesData('Kumma', 150),
      SalesData('Dagger', 40),
      SalesData('Jalabiya', 200),
      SalesData('Glasses', 170),
      SalesData('Dagger', 120),
    ];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(16.0),
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(text: 'Monthly Sales of Products'),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries>[
              BarSeries<SalesData, String>(
                dataSource: salesData,
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                xValueMapper: (SalesData data, _) => data.productName,
                yValueMapper: (SalesData data, _) => data.sales,
                name: 'Sales',
                isTrackVisible: true, // Show background for the bar
                dataLabelSettings: const DataLabelSettings(isVisible: true), // Display sales values
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Class representing sales data
class SalesData {
  SalesData(this.productName, this.sales);
  final String productName;
  final double sales;
}
