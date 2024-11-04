import 'package:cube_business/core/app_theme.dart';
import 'package:cube_business/provider/auth_provider.dart';
import 'package:cube_business/provider/user_provider.dart';
import 'package:cube_business/provider/store_provider.dart';
import 'package:cube_business/services/auth_service.dart';
import 'package:cube_business/views/pages/auth/auth_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // تهيئة Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Auth_Provider()),
        ChangeNotifierProvider(
          create: (_) => StoreProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        StreamProvider<User?>.value(
          value: AuthService().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cube Business',
        theme: AppTheme.lightTheme,
        home: AuthWrapper(),
        // locale: const Locale('ar'),
        // localizationsDelegates: const [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        // supportedLocales: const [
        //   Locale('ar'), // اللغة العربية
        //   Locale('en'), // اللغة الإنجليزية
        // ],
      ),
    );
  }
}

// شاشة تسجيل الدخول
