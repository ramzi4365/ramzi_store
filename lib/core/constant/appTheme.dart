import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ramzi_store/core/constant/color.dart';

ThemeData themeEnglish = ThemeData(
  fontFamily: "PlayfairDisplay",
  primaryColor: const Color(0xFF2C3E50),
  primarySwatch: Colors.blue,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF2C3E50),
    secondary: Color(0xFFE74C3C),
    surface: Color(0xFFF8F9FA),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.5,
    ),
    displayMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(fontSize: 16),
    bodyMedium: TextStyle(fontSize: 14),
    bodySmall: TextStyle(
      height: 2,
      color: AppColor.grey,
      fontSize: 14,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  ),
);




ThemeData themeArabic = ThemeData(
  fontFamily: "Cairo",
  primaryColor: const Color(0xFF2C3E50),
  primarySwatch: Colors.blue,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF2C3E50),
    secondary: Color(0xFFE74C3C),
    surface: Color(0xFFF8F9FA),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.5,
    ),
    displayMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(fontSize: 16),
    bodyMedium: TextStyle(fontSize: 14),
    bodySmall: TextStyle(
      height: 2,
      color: AppColor.grey,
      fontSize: 14,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  ),
);