import 'package:cube_business/core/app_theme.dart';
import 'package:cube_business/services/auth_service.dart';
import 'package:cube_business/views/pages/add_product/add_product.dart';
import 'package:cube_business/views/pages/auth/auth_wrapper.dart';
import 'package:cube_business/views/pages/home/home_screen.dart';
import 'package:cube_business/views/pages/products/product_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // تهيئة Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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

        // تحديد اللغة الافتراضية للعربية
        locale: const Locale('ar'),

        // دعم الاتجاه من اليمين إلى اليسار
        builder: (context, widget) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: widget!,
          );
        },

        // إعدادات التوطين والدعم للغات الأخرى
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar'), // اللغة العربية
          Locale('en'), // اللغة الإنجليزية
        ],
      ),
    );
  }
}

// شاشة تسجيل الدخول
