import 'package:cube_business/views/pages/auth/login_screen.dart';
import 'package:cube_business/views/pages/add%20store/add_store.dart';
import 'package:cube_business/views/pages/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user != null) {
      // print(OneSignal.User.pushSubscription.id);
      // NotificationsService().savePlayerIdToFirestore(
      //     OneSignal.User.pushSubscription.id.toString(), user.uid);
    }
    return user == null ? LoginScreen() : const HomeScreen();
  }
}
