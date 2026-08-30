import 'package:flutter/material.dart';
import 'package:portfolio/core/themes/app_colors.dart';
import 'package:portfolio/core/themes/app_text_styles.dart';

class TechPill extends StatelessWidget {
  final String label;
  const TechPill({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.tagBg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.tagBorder),
      ),
      child: Text(label, style: AppTextStyles.techTag),
    );
  }
}
