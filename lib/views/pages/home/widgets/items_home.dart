import 'dart:async';
import 'package:cube_business/core/helper/nav_helper.dart';
import 'package:cube_business/model/user_model.dart';
import 'package:cube_business/services/auth_service.dart';
import 'package:cube_business/services/product_screvice.dart';
import 'package:cube_business/views/pages/add_product/add_product.dart';
import 'package:cube_business/views/pages/home/widgets/item.dart';
import 'package:cube_business/views/pages/products/product_screen.dart';
import 'package:flutter/material.dart';

class ItemsHome extends StatefulWidget {
  const ItemsHome({super.key});

  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<ItemsHome> {
  String productCount = "0"; // Set a default value
  bool isLoading = true;
  Timer? _timer;
  int _animationCounter = 0;

  @override
  void initState() {
    super.initState();
    startLoadingAnimation();
    fetchProductCount();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startLoadingAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _animationCounter++;
        productCount = (_animationCounter % 100).toString(); // Animated number
      });
    });
  }

  Future<void> fetchProductCount() async {
    UserModel? currentUser = await AuthService().getCurrentUserData();
    if (currentUser != null) {
      ProductService productService =
          ProductService(storeId: currentUser.storeId!);
      int count = await productService.countProducts();
      _timer?.cancel(); // Stop the animation once data is loaded
      setState(() {
        productCount = count.toString(); // Update the product count
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Items(
                  title: 'اضف منتج',
                  icon: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[850], shape: BoxShape.circle),
                      child: const Icon(Icons.add, color: Colors.white)),
                  backgroundColor: Colors.black,
                  onTap: () => navigateTo(context, AddProductScreen()),
                  value: '',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Items(
                  title: 'المبيعات الشهريه',
                  value: '0 ر.ع',
                  percentage: '+1.3%',
                  backgroundColor: Colors.white,
                  progressColor: Colors.green,
                  progressValue: 0.12,
                  onTap: () => navigateTo(context, ProductsListScreen()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Items(
                  title: 'ادارة السلع',
                  value:
                      productCount, // Display the animated or real product count
                  percentage: '+100%',
                  backgroundColor: Colors.white,
                  progressColor: Colors.green,
                  progressValue: 1,
                  onTap: () => navigateTo(context, ProductsListScreen()),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Items(
                  title: 'طلبات',
                  value: '0',
                  percentage: '0%',
                  backgroundColor: Colors.white,
                  progressColor: Colors.white,
                  progressValue: 0.0,
                  onTap: () => navigateTo(context, ProductsListScreen()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Items(
                  title: 'ادارة المتجر',
                  percentage: '',
                  icon: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200], shape: BoxShape.circle),
                    child: const Icon(Icons.settings, color: Colors.black),
                  ),
                  backgroundColor: Colors.white,
                  onTap: () => navigateTo(context, ProductsListScreen()),
                  value: '',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Items(
                  title: 'ادوات الترويج',
                  value: '',
                  icon: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200], shape: BoxShape.circle),
                    child:
                        const Icon(Icons.business_sharp, color: Colors.black),
                  ),
                  backgroundColor: Colors.white,
                  progressValue: 0.0,
                  onTap: () => navigateTo(context, ProductsListScreen()),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String title;

  const DetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Details for $title'),
      ),
    );
  }
}
