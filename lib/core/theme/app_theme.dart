import 'package:flutter/material.dart';

/// Palette de couleurs de l'app (issue des maquettes).
class AppColors {
  static const background = Color(0xFF0E1116);
  static const surface = Color(0xFF1B2027);
  static const accent = Color(0xFF34D6A5);
  static const live = Color(0xFFFF4655);
  static const textMain = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xFF8A93A2);
}

/// Fournit le thème de l'application.
class AppTheme {
  /// Thème sombre Material 3 utilisé par toute l'app.
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        surface: AppColors.surface,
        primary: AppColors.accent,
      ),
      cardColor: AppColors.surface,
      useMaterial3: true,
    );
  }
}
