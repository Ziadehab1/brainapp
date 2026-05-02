import 'package:flutter/material.dart';

import '../../core/resources/app_colors.dart';
import '../../core/resources/font_manager.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surfaceDark,
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontFamily: FontManager.primaryFont,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          bodyLarge: TextStyle(
            fontFamily: FontManager.primaryFont,
            fontSize: 16,
            color: AppColors.textPrimary,
          ),
          bodyMedium: TextStyle(
            fontFamily: FontManager.primaryFont,
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.backgroundDark,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.textPrimary),
        ),
      );
}