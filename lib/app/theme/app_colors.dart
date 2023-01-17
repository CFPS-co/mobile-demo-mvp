import 'package:flutter/material.dart';

///
/// Color names should be based on http://chir.ag/projects/name-that-color/
///
/// ```dart
/// static const turquoise = Color(0xFF27DFB1);
/// ```
///
///
class AppColors {
  AppColors._();

  static const athensGray = Color(0xFFE9E9EB);
  static const bitterSweet = Color(0xFFFF7070);
  static const black = Color(0xFF000000);
  static const blackHaze = Color(0xFFF2F3F3);
  static const blueDianne = Color(0xFF1F504B);
  static const concrete = Color(0xFFF2F2F2);
  static const edward = Color(0xFF99A3A3);
  static const gray = Color(0xFF828282);
  static const iron = Color(0xFFCCD1D1);
  static const silverSand = Color(0xFFC2C8C8);
  static const white = Color(0xFFFFFFFF);
  static const holly05 = Color(0x0D011A1A);
  static const holly10 = Color(0x1A011A1A);
  static const holly40 = Color(0x66011A1A);
  static const holly = Color(0xff011A1A);

  static Color get transparent => Colors.transparent;
  static Color get defaultBackground => concrete;
  static Color get defaultInactiveColor => blackHaze;
  static Color get defaultActiveColor => blueDianne;
}
