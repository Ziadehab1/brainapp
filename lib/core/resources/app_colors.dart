import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF7B5EA7);
  static const Color secondary = Color(0xFF9B7FC7);
  static const Color backgroundDark = Color(0xFF1A1A2E);
  static const Color surfaceDark = Color(0xFF16213E);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0C8);
  static const Color error = Color(0xFFE57373);
  static const Color success = Color(0xFF81C784);
  static const Color warning = Color(0xFFFFB74D);
  static const Color divider = Color(0xFF2A2A4A);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF7B5EA7), Color(0xFF4A3F8F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}