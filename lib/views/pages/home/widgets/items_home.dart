import 'package:cube_business/core/helper/nav_helper.dart';
import 'package:cube_business/provider/home_provider.dart';
import 'package:cube_business/views/pages/home/widgets/item.dart';
import 'package:cube_business/views/pages/promtion/promotion.page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cube_business/services/auth_service.dart';
import 'package:cube_business/services/product_screvice.dart';
import 'package:cube_business/views/pages/add_product/add_product.dart';
import 'package:cube_business/views/pages/statistics/statistics_screen.dart';
import 'package:cube_business/views/pages/products/product_list_screen.dart';
import 'package:cube_business/views/pages/order/order_list.dart';
import 'package:cube_business/views/pages/profile_store/edit_profile.dart';
import 'package:cube_business/views/widgets/items.dart';
import 'package:cube_business/model/user_model.dart';

class ItemsHome extends StatelessWidget {
  const ItemsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                // Row 1: Add Product and Monthly Sales
                ItemsRow(
                  items: [
                    Items(
                      title: 'Add Product',
                      icon: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[850], shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                      backgroundColor: Colors.black,
                      onTap: () => navigateTo(context, AddProductScreen()),
                      value: '',
                    ),
                    Items(
                      title: 'Statistics',
                      value: '0 OMR',
                      percentage: '+1.3%',
                      backgroundColor: Colors.white,
                      progressColor: Colors.green,
                      progressValue: 0.12,
                      onTap: () => navigateTo(context, StatisticsScreen()),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Row 2: Product Management and Orders
                ItemsRow(
                  items: [
                    Items(
                      title: 'Product Management',
                      value: homeProvider.productCount, // Display the animated or real product count
                      percentage: '',
                      backgroundColor: Colors.white,
                      progressColor: Colors.green,
                      progressValue: 1,
                      onTap: () => navigateTo(context, ProductsListScreen()),
                    ),
                    Items(
                      title: 'Orders',
                      value: '0',
                      percentage: '0%',
                      backgroundColor: Colors.white,
                      progressColor: Colors.white,
                      progressValue: 0.0,
                      onTap: () => navigateTo(context, OrderListScreen()),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Row 3: Store Management and Promotion Tools
                ItemsRow(
                  items: [
                    Items(
                      title: 'Account Management',
                      percentage: '',
                      icon: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200], shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.settings, color: Colors.black),
                      ),
                      backgroundColor: Colors.white,
                      onTap: () => navigateTo(context, EditProfile()),
                      value: '',
                    ),
                    Items(
                      title: 'Promotion Tools',
                      value: '',
                      icon: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200], shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.business_sharp, color: Colors.black),
                      ),
                      backgroundColor: Colors.white,
                      progressValue: 0.0,
                      onTap: () => navigateTo(context, PromotionPage()),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
