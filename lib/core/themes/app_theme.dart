import 'package:flutter/material.dart';
import 'package:portfolio/core/themes/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.bgPrimary,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accent,
      secondary: AppColors.secondary,
      surface: AppColors.bgSecondary,
    ),
  textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Inter'),
    useMaterial3: true,
  );
}
