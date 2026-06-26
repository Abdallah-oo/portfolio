import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Backgrounds ──────────────────────────────────────────────
  static const Color bgPrimary = Color(0xFF0B0E1A); // deep navy-black
  static const Color bgSecondary = Color(0xFF111827); // card surface
  static const Color bgTertiary = Color(0xFF1C2333); // hover / elevated

  // ── Accents ──────────────────────────────────────────────────
  static const Color accent = Color(0xFF6C8EF5); // soft indigo-blue
  static const Color accentLight = Color(0xFF93AAF8); // lighter tint
  static const Color accentGlow = Color(0x336C8EF5); // glow / bg overlay

  static const Color secondary = Color(0xFF8B5CF6); // soft violet
  static const Color secondaryGlow = Color(0x338B5CF6);

  // ── Text ─────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFFE8EDF5); // near-white
  static const Color textSecondary = Color(0xFF8A95A8); // muted
  static const Color textTertiary = Color(0xFF4A5568); // very muted

  // ── Borders ──────────────────────────────────────────────────
  static const Color border = Color(0xFF1E2840);
  static const Color borderHover = Color(0xFF6C8EF5);

  // ── Skill tag backgrounds ─────────────────────────────────────
  static const Color tagBg = Color(0xFF161D2F);
  static const Color tagBorder = Color(0xFF2A3554);

  // ── Gradient ─────────────────────────────────────────────────
  static const LinearGradient accentGradient = LinearGradient(
    colors: [accent, secondary],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF0B0E1A), Color(0xFF131929)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
