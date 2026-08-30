import 'package:flutter/material.dart';
import 'package:portfolio/core/themes/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get heroName => TextStyle(
    fontFamily: 'Inter',
    fontSize: 56,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.1,
    letterSpacing: -1.5,
  );

  static TextStyle get heroNameMobile => TextStyle(
    fontFamily: 'Inter',
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.1,
    letterSpacing: -1.0,
  );

  static TextStyle get heroRole => TextStyle(
    fontFamily: 'FiraCode',
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.accent,
    letterSpacing: 0.5,
  );

  static TextStyle get heroSummary => TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.7,
  );

  static TextStyle get sectionTitle => TextStyle(
    fontFamily: 'Inter',
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle get sectionTitleMobile => TextStyle(
    fontFamily: 'Inter',
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  static TextStyle get sectionLabel => TextStyle(
    fontFamily: 'FiraCode',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.accent,
    letterSpacing: 2.0,
  );

  static TextStyle get cardTitle =>
      TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary);

  static TextStyle get cardSubtitle =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.accent);

  static TextStyle get cardBody => TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.65,
  );

  static TextStyle get techTag =>
      TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.accentLight);

  static TextStyle get navLink =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textSecondary);

  static TextStyle get navLinkActive =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.accent);

  static TextStyle get buttonPrimary =>
      TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: 0.3);

  static TextStyle get buttonSecondary => TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.accent,
    letterSpacing: 0.3,
  );

  static TextStyle get projectNumber =>
      TextStyle(fontSize: 48, fontWeight: FontWeight.w700, color: AppColors.accentGlow);

  static TextStyle get skillCategory => TextStyle(
    fontFamily: 'Inter',
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );
}
