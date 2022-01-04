import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme() {
    return ThemeData(
      primaryColor: colorPrimary,
      fontFamily: 'SFPro',
      backgroundColor: Colors.white,
      textTheme: const TextTheme(
        headline4: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
        headline5: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        headline6: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        bodyText1: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF091B3D)),
        caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
        button: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: colorPrimary)
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
        )
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87
      ),

    );
  }

  static OutlineInputBorder outlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
          color: Color(0xFFE7E8EC)
      ),
      borderRadius: BorderRadius.circular(18.0),
    );
  }

  static const Color colorPrimary = Color(0xFF499D2F);
  static const Color colorSecondary = Color(0xFFE1EFDD);
}