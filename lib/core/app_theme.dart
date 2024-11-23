
import 'package:cube_business/core/color_constant.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'cubefont',
    primaryColor: AppColor.primaryColor,

        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColor.primaryColor, // This also sets the primary color
        ),
    hintColor: AppColor.accentColor,
    scaffoldBackgroundColor: const Color.fromARGB(255, 234, 234, 234),
appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColor.primaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.primaryColor),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.primaryColor),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.primaryColor),
      ),
      labelStyle: const TextStyle(color: AppColor.primaryColor),
      hintStyle: TextStyle(color: AppColor.primaryColor.withOpacity(0.6)),
    ),
    iconTheme: const IconThemeData(
      color: AppColor.primaryColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColor.primaryColor,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(AppColor.primaryColor),
      checkColor: WidgetStateProperty.all(AppColor.accentColor),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(AppColor.primaryColor),
    ),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.all(AppColor.primaryColor.withOpacity(0.5)),
      thumbColor: WidgetStateProperty.all(AppColor.primaryColor),
    ),
  );

  // static final ThemeData darkTheme = ThemeData(
  //   brightness: Brightness.dark,
  //       fontFamily: 'cubefont',

  //   primaryColor: AppColor.primaryColor,
  //   hintColor: AppColor.accentColor,
  //   scaffoldBackgroundColor: Colors.black,

  //   buttonTheme: const ButtonThemeData(
  //     buttonColor: AppColor.primaryColor,
  //     textTheme: ButtonTextTheme.primary,
  //   ),
  //   textTheme: const TextTheme(
  //     bodyLarge: TextStyle(color: AppColor.accentColor),
  //     bodyMedium: TextStyle(color: AppColor.accentColor),
  //     displayLarge: TextStyle(color: AppColor.accentColor, fontSize: 32, fontWeight: FontWeight.bold),
  //     titleLarge: TextStyle(color: AppColor.accentColor, fontSize: 20),
  //   ),
  //   inputDecorationTheme: InputDecorationTheme(
  //     border: const OutlineInputBorder(
  //       borderSide: BorderSide(color: AppColor.accentColor),
  //     ),
  //     focusedBorder: const OutlineInputBorder(
  //       borderSide: BorderSide(color: AppColor.accentColor),
  //     ),
  //     enabledBorder: const OutlineInputBorder(
  //       borderSide: BorderSide(color: AppColor.accentColor),
  //     ),
  //     labelStyle: const TextStyle(color: AppColor.accentColor),
  //     hintStyle: TextStyle(color: AppColor.accentColor.withOpacity(0.6)),
  //   ),
  //   iconTheme: const IconThemeData(
  //     color: AppColor.accentColor,
  //   ),
  //   floatingActionButtonTheme: const FloatingActionButtonThemeData(
  //     backgroundColor: AppColor.primaryColor,
  //   ),
  //   checkboxTheme: CheckboxThemeData(
  //     fillColor: MaterialStateProperty.all(AppColor.primaryColor),
  //     checkColor: MaterialStateProperty.all(AppColor.accentColor),
  //   ),
  //   radioTheme: RadioThemeData(
  //     fillColor: MaterialStateProperty.all(AppColor.primaryColor),
  //   ),
  //   switchTheme: SwitchThemeData(
  //     trackColor: MaterialStateProperty.all(AppColor.primaryColor.withOpacity(0.5)),
  //     thumbColor: MaterialStateProperty.all(AppColor.primaryColor),
  //   ),
  // );
}