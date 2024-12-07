import 'package:cube_business/core/helper/nav_helper.dart';
import 'package:cube_business/provider/user_provider.dart';
import 'package:cube_business/views/pages/bot/bot_screen.dart';
import 'package:cube_business/views/pages/payment/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cube_business/views/pages/home/widgets/items_home.dart';
import 'package:cube_business/views/widgets/drawer_widget/drawer_widget.dart';
import 'package:cube_business/views/widgets/my_background.dart';

import '../add store/add_store.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).loadCurrentUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Show loading indicator while loading
    if (userProvider.isLoading) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }


    // If the currentUser or storeId is null, navigate to EnterDetailsScreen
    if (userProvider.currentUser!.storeId == null) {
      return Scaffold(
          backgroundColor: Colors.grey[200], body: const EnterDetailsScreen());
    }

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        child: Image.asset(
          'assets/icon/user-robot.png',
          color: Colors.white,
          width: 30,
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height *
                    0.6, // 60% of screen height
                padding: const EdgeInsets.all(16.0),

                child: const BotScreen(),
              );
            },
          );
        },
      ),
      backgroundColor: Colors.grey[250],
      drawer: const DrawerWidget(),
      body: MyBackground(
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return ListView(
              padding: const EdgeInsets.all(10.0),
              children: [
                const SizedBox(height: 70),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          userProvider.currentStore?.logoUrl ??
                              'https://via.placeholder.com/150',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Hi ${userProvider.currentUser?.fullName ?? 'User'}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                userProvider.currentStore!.aictived?
                 ItemsHome():Center(child: ElevatedButton
                 
                 
                 
                 (
                  style: ButtonStyle(backgroundColor:WidgetStatePropertyAll(Colors.black)),
                  
                  
                  onPressed: (){navigateTo(context, PricingCard());}, child: Text('Subscripe', style: TextStyle(color: Colors.white),)))
              ],
            );
          },
        ),
      ),
    );
  }
}
