import 'package:cube_business/services/auth_service.dart';
import 'package:cube_business/views/pages/add%20store/add_store.dart';
import 'package:cube_business/views/pages/home/widgets/items_home.dart';
import 'package:cube_business/views/widgets/drawer_widget/drawer_widget.dart';
import 'package:cube_business/views/widgets/my_background.dart';
import 'package:flutter/material.dart';
import 'package:cube_business/model/user_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? currentUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    currentUser = await AuthService().getCurrentUserData();
    if (currentUser == null || currentUser!.storeId == null) {
      _navigateToEnterDetailsScreen();
    } else {
      setState(
          () {}); // Trigger a rebuild if the user data is successfully loaded
    }
  }

  void _navigateToEnterDetailsScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const EnterDetailsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser == null || currentUser!.storeId == null) {
      // Show a loading indicator while the user data is being fetched
      return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey[250],
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton:
          FloatingActionButton(child: const Icon(Icons.assistant), onPressed: () {}),
      backgroundColor: Colors.grey[250],
      drawer: const DrawerWidget(),
      body: MyBackground(
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            const SizedBox(height: 70),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //drwaer
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/image/avatar.png'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'مرحبا بك علي',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                // IconButton(
                //   onPressed: () async {
                //     await AuthService().signOut();
                //     // Navigate to the login screen or any other relevant screen after signing out
                //   },
                //   icon: const Icon(
                //     Icons.menu,
                //     color: Colors.black,
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 20),
            const ItemsHome(),
          ],
        ),
      ),
    );
  }
}
