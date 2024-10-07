import 'package:cube_business/core/helper/nav_helper.dart';
import 'package:cube_business/provider/home_provider.dart';
import 'package:cube_business/views/pages/home/widgets/item.dart';
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
                    Items(
                      title: 'الاحصاءات',
                      value: '0 ر.ع',
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
                      title: 'ادارة السلع',
                      value: homeProvider.productCount, // Display the animated or real product count
                      percentage: '+100%',
                      backgroundColor: Colors.white,
                      progressColor: Colors.green,
                      progressValue: 1,
                      onTap: () => navigateTo(context, ProductsListScreen()),
                    ),
                    Items(
                      title: 'طلبات',
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
                      title: 'ادارة المتجر',
                      percentage: '',
                      icon: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.grey[200], shape: BoxShape.circle),
                        child: const Icon(Icons.settings, color: Colors.black),
                      ),
                      backgroundColor: Colors.white,
                      onTap: () => navigateTo(context, EditProfile()),
                      value: '',
                    ),
                    Items(
                      title: 'ادوات الترويج',
                      value: '',
                      icon: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.grey[200], shape: BoxShape.circle),
                        child: const Icon(Icons.business_sharp, color: Colors.black),
                      ),
                      backgroundColor: Colors.white,
                      progressValue: 0.0,
                      onTap: () => navigateTo(context, ProductsListScreen()),
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
