import 'package:flutter/material.dart';

class AppColors {
  static final AppColors _instance = AppColors._internal();
  factory AppColors() => _instance;
  AppColors._internal();

  static const Color primary = Color(0xff023047);
  static const Color kakaoYellow = Color(0xFFFFE812);
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Grayscale colors
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);
}
