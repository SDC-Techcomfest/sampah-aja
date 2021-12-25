import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme() {
    return ThemeData(
      primaryColor: colorPrimary,
      fontFamily: 'Manrope',
      textTheme: const TextTheme(
        headline4: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        headline5: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
        caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
        button: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: colorPrimary)
      )
    );
  }

  static const Color colorPrimary = Color(0xFF499D2F);
  static const Color colorSecondary = Color(0xFFE1EFDD);
}