import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProductSalesChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // بيانات مبيعات المنتجات كمثال
    final List<SalesData> salesData = [
      SalesData('كمه', 150),
      SalesData('خنجر', 40),
      SalesData('جلابية', 200),
      SalesData('نظارة', 170),
      SalesData('خنجر', 120),
    ];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.all(16.0),
          child: SfCartesianChart(
            
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(text: 'المبيعات الشهرية للمنتجات'),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <CartesianSeries>[
              BarSeries<SalesData, String>(
                dataSource: salesData,
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
                xValueMapper: (SalesData data, _) => data.productName,
                yValueMapper: (SalesData data, _) => data.sales,
                name: 'المبيعات',
                isTrackVisible: true, // عرض الخلفية للشريط
                dataLabelSettings: const DataLabelSettings(isVisible: true), // إظهار قيم المبيعات
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// فئة تمثل بيانات المبيعات
class SalesData {
  SalesData(this.productName, this.sales);
  final String productName;
  final double sales;
}
