import 'package:cube_business/model/order_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 2 tabs: New Order, Done
  }

  Stream<List<OrderModel>> getOrders(String status) {
    return FirebaseFirestore.instance
        .collection('orders')
        .where('status', isEqualTo: status)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'New Order'),
            Tab(text: 'Done'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          StreamBuilder<List<OrderModel>>(
            stream: getOrders('new'), // Fetch new orders
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No New Orders'));
              }
              return OrderListWidget(
                orders: snapshot.data!,
                leadingIcon: Icons.shopping_bag,
                leadingIconColor: Colors.black,
                trailingIcon: Icons.done,
                trailingIconColor: const Color.fromARGB(255, 42, 146, 46),
                trailingBackgroundColor: Colors.green.withOpacity(0.2),
              );
            },
          ),
          StreamBuilder<List<OrderModel>>(
            stream: getOrders('done'), // Fetch completed orders
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No Completed Orders'));
              }
              return OrderListWidget(
                orders: snapshot.data!,
                leadingIcon: Icons.check_circle,
                leadingIconColor: Colors.green,
                trailingIcon: Icons.arrow_forward_ios,
                trailingIconColor: Colors.grey,
              );
            },
          ),
        ],
      ),
    );
  }
}


class OrderListWidget extends StatelessWidget {
  final List<OrderModel> orders;
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
              onTap: () async {
                // Change status to "done" on tap
                await order.updateStatus("done");
              },
            ),
          ),
        );
      },
    );
  }
}
