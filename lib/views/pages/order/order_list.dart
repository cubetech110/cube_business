import 'package:flutter/material.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 2 tabs: New Order, Completed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(''),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'طلب جديد'),
            Tab(text: 'تم الإنجاز'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OrderListWidget(
            orders: [
              Order(
                userName: 'محمد سعيد البوصافي',
                userPhone: '90979774',
                productDetails: 'حاسوب محمول - 16GB RAM - 512GB SSD',
              ),
              Order(
                userName: 'سالم الكندي',
                userPhone: '98765432',
                productDetails: 'هاتف ذكي - iPhone 12 Pro',
              ),
            ],
            leadingIcon: Icons.shopping_bag,
            leadingIconColor: Colors.black,
            trailingIcon: Icons.done,
            trailingIconColor: const Color.fromARGB(255, 42, 146, 46),
            trailingBackgroundColor: Colors.green.withOpacity(0.2),
          ),
          OrderListWidget(
            orders: [
              Order(
                userName: 'علي الحارثي',
                userPhone: '99887766',
                productDetails: 'طابعة ليزر - HP LaserJet Pro',
              ),
            ],
            leadingIcon: Icons.check_circle,
            leadingIconColor: Colors.green,
            trailingIcon: Icons.arrow_forward_ios,
            trailingIconColor: Colors.grey,
          ),
        ],
      ),
    );
  }
}

// Reusable OrderListWidget
class OrderListWidget extends StatelessWidget {
  final List<Order> orders;
  final IconData leadingIcon;
  final Color leadingIconColor;
  final IconData trailingIcon;
  final Color trailingIconColor;
  final Color? trailingBackgroundColor;

  const OrderListWidget({
    required this.orders,
    required this.leadingIcon,
    required this.leadingIconColor,
    required this.trailingIcon,
    required this.trailingIconColor,
    this.trailingBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: Icon(leadingIcon, color: leadingIconColor),
              title: Text('${order.userName} - ${order.userPhone}'),
              subtitle: Text(order.productDetails),
              trailing: trailingBackgroundColor != null
                  ? Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: trailingBackgroundColor,
                      ),
                      child: Icon(trailingIcon, color: trailingIconColor),
                    )
                  : Icon(trailingIcon, color: trailingIconColor),
              onTap: () {
                // Handle order tap
              },
            ),
          ),
        );
      },
    );
  }
}

// Order Model
class Order {
  final String userName;
  final String userPhone;
  final String productDetails;

  Order({
    required this.userName,
    required this.userPhone,
    required this.productDetails,
  });
}
