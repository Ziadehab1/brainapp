import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // --- Core backgrounds ---
  static const Color background = Color(0xFF0D0B1E);
  static const Color backgroundOnboarding = Color(0xFF0D0D2B);
  static const Color backgroundSplash = Color(0xFF0B0B1E);

  // --- Surfaces / card backgrounds ---
  static const Color surface = Color(0xFF1C1A34);
  static const Color surfaceDark = Color(0xFF16142A);
  static const Color surfaceDeep = Color(0xFF1A1040);
  static const Color surfaceMedium = Color(0xFF2A2050);
  static const Color surfaceOverlay = Color(0xFF2D2060);
  static const Color surfaceOnboarding = Color(0xFF1C1C3A);

  // --- Primary accent (light purple) ---
  static const Color primary = Color(0xFFB8A8E8);
  static const Color primaryLight = Color(0xFFCFC5F0);
  static const Color primaryLighter = Color(0xFFD0C8F0);
  static const Color primaryMuted = Color(0xFF8B7FD4);
  static const Color primaryDeep = Color(0xFF4A3B8C);

  // --- Semantic ---
  static const Color error = Color(0xFFE87878);

  // --- UI utility ---
  static final Color barrierDark = Colors.black.withValues(alpha: 0.6);
  static final Color divider = Colors.white.withValues(alpha: 0.06);
  static final Color sheetHandle = Colors.white.withValues(alpha: 0.15);
  static const Color cancelText = Colors.white54;

  // --- Tutorial category gradients ---
  static const Color tutorialPurpleStart = Color(0xFF3B2F6E);
  static const Color tutorialPurpleEnd = Color(0xFF6B5B9E);
  static const Color tutorialGreenStart = Color(0xFF1A3A2A);
  static const Color tutorialGreenEnd = Color(0xFF2E6B4A);
  static const Color tutorialRedStart = Color(0xFF3A2020);
  static const Color tutorialRedEnd = Color(0xFF7A3A3A);
  static const Color tutorialBlueStart = Color(0xFF1A2A3A);
  static const Color tutorialBlueEnd = Color(0xFF2A4A6A);
  static const Color tutorialVioletStart = Color(0xFF2A1A3A);
  static const Color tutorialVioletEnd = Color(0xFF5A3A7A);
  static const Color tutorialNavyStart = Color(0xFF1A1A3A);
  static const Color tutorialNavyEnd = Color(0xFF3A3A6A);
  static const Color tutorialLimeStart = Color(0xFF2A3A1A);
  static const Color tutorialLimeEnd = Color(0xFF4A7A2A);
  static const Color tutorialIndigoStart = Color(0xFF1E1A3E);
  static const Color tutorialIndigoEnd = Color(0xFF4A3A8E);

  // --- Exercise category gradients ---
  static const Color exerciseTealStart = Color(0xFF1A3A3A);
  static const Color exerciseTealEnd = Color(0xFF2A6A6A);
  static const Color exercisePinkStart = Color(0xFF3A1A2A);
  static const Color exercisePinkEnd = Color(0xFF7A2A5A);
  static const Color exercisePurpleStart = Color(0xFF2A1F5A);
  static const Color exercisePurpleEnd = Color(0xFF5A4A9E);

  // --- Game category gradients ---
  static const Color gameBrownStart = Color(0xFF3A2A10);
  static const Color gameBrownEnd = Color(0xFF7A6530);
  static const Color gameForestStart = Color(0xFF0E2A1A);
  static const Color gameForestEnd = Color(0xFF1E5038);

  // --- Mood gradients ---
  static const Color moodHappyStart = Color(0xFF2A1F5A);
  static const Color moodHappyEnd = Color(0xFF6B5BAE);
  static const Color moodAngryStart = Color(0xFF3A1A1A);
  static const Color moodAngryEnd = Color(0xFF7A3A2A);
  static const Color moodCalmStart = Color(0xFF1A3A3A);
  static const Color moodCalmEnd = Color(0xFF2A6A5A);
  static const Color moodSadStart = Color(0xFF1A1A3A);
  static const Color moodSadEnd = Color(0xFF3A2A6A);
  static const Color moodAnxiousStart = Color(0xFF1A2A3A);
  static const Color moodAnxiousEnd = Color(0xFF2A4A6A);

  // --- Emotion color palette (emotions_diary) ---
  static const List<Color> emotionPalette = [
    Color(0xFF2A1F5A),
    Color(0xFF3B2F6E),
    Color(0xFF4A3B8C),
    Color(0xFF5A4A9E),
    Color(0xFF6B5BAE),
    Color(0xFF1A2A3A),
    Color(0xFF1A3A2A),
    Color(0xFF3A1A2A),
  ];

  // --- Card game colors (flipping_card_screen) ---
  static const List<Color> cardGameColors = [
    Color(0xFF9B59B6),
    Color(0xFF2980B9),
    Color(0xFF27AE60),
    Color(0xFFE67E22),
    Color(0xFFE74C3C),
    Color(0xFF1ABC9C),
    Color(0xFFF39C12),
    Color(0xFF8E44AD),
    Color(0xFF16A085),
    Color(0xFFD35400),
  ];
}
