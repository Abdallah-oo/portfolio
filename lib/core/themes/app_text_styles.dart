

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/themes/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static TextStyle get heroName => GoogleFonts.inter(
    fontSize: 56,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.1,
    letterSpacing: -1.5,
  );

  static TextStyle get heroNameMobile => GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
    height: 1.1,
    letterSpacing: -1.0,
  );

  static TextStyle get heroRole => GoogleFonts.firaCode(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.accent,
    letterSpacing: 0.5,
  );

  static TextStyle get heroSummary => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.7,
  );

  static TextStyle get sectionTitle => GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle get sectionTitleMobile => GoogleFonts.inter(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  static TextStyle get sectionLabel => GoogleFonts.firaCode(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.accent,
    letterSpacing: 2.0,
  );

  static TextStyle get cardTitle => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get cardSubtitle => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.accent,
  );

  static TextStyle get cardBody => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.65,
  );

  static TextStyle get techTag => GoogleFonts.firaCode(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.accentLight,
  );

  static TextStyle get navLink => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
  );

  static TextStyle get navLinkActive => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.accent,
  );

  static TextStyle get buttonPrimary => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.3,
  );

  static TextStyle get buttonSecondary => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.accent,
    letterSpacing: 0.3,
  );

  static TextStyle get projectNumber => GoogleFonts.firaCode(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: AppColors.accentGlow,
  );

  static TextStyle get skillCategory => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );
}
