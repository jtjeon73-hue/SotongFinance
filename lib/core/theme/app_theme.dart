import 'package:flutter/material.dart';

/// 딥 네이비·블루·청록·골드 포인트 기반 밝은 전문 테마
class AppColors {
  static const Color deepNavy = Color(0xFF0B1F3A);
  static const Color navy = Color(0xFF14375A);
  static const Color blue = Color(0xFF1F6AA5);
  static const Color teal = Color(0xFF0D7377);
  static const Color gold = Color(0xFFB8860B);
  static const Color lightGray = Color(0xFFF4F7FA);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1A2332);
  static const Color textSecondary = Color(0xFF5A6577);
  static const Color danger = Color(0xFFB42318);
  static const Color warning = Color(0xFFB54708);
  static const Color success = Color(0xFF027A48);
  static const Color info = Color(0xFF175CD3);
  static const Color tax = Color(0xFF6941C6);
  static const Color official = Color(0xFF0E7490);
  static const Color scenario = Color(0xFF9A3412);
  static const Color action = Color(0xFF047857);
}

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.blue,
        primary: AppColors.navy,
        secondary: AppColors.teal,
        tertiary: AppColors.gold,
        surface: AppColors.cardWhite,
        error: AppColors.danger,
      ),
      scaffoldBackgroundColor: AppColors.lightGray,
      fontFamily: 'Noto Sans KR',
    );

    return base.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.deepNavy,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.black.withValues(alpha: 0.06)),
        ),
      ),
      drawerTheme: const DrawerThemeData(backgroundColor: AppColors.cardWhite),
      navigationRailTheme: const NavigationRailThemeData(
        backgroundColor: AppColors.cardWhite,
        selectedIconTheme: IconThemeData(color: AppColors.teal),
        selectedLabelTextStyle: TextStyle(
          color: AppColors.navy,
          fontWeight: FontWeight.w700,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.navy,
          foregroundColor: Colors.white,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.navy,
          minimumSize: const Size(48, 48),
          side: const BorderSide(color: AppColors.navy),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
    );
  }
}
