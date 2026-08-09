import 'package:flutter/material.dart';
import 'package:portfolio/core/themes/app_colors.dart';
import 'package:portfolio/core/themes/app_text_styles.dart';


class SectionHeader extends StatelessWidget {

  final String title;

  const SectionHeader({super.key,  required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
     
        const SizedBox(height: 8),
        ShaderMask(
          shaderCallback: (b) => AppColors.accentGradient.createShader(b),
          blendMode: BlendMode.srcIn,
          child: Text(
            title,
            style: MediaQuery.of(context).size.width > 768
                ? AppTextStyles.sectionTitle
                : AppTextStyles.sectionTitleMobile,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 48,
          height: 3,
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
