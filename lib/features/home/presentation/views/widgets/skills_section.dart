import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_strings.dart';
import 'package:portfolio/core/extensions/responsive.dart';
import 'package:portfolio/core/themes/app_colors.dart';
import 'package:portfolio/core/themes/app_text_styles.dart';
import 'package:portfolio/core/widgets/custom_text.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isWide = context.screenWidth > 768;

    return VisibilityDetector(
      key: const Key('skills'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isWide ? 64 : 24,
          vertical: 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SectionHeader(title: 'Tech Stack'),
            const SizedBox(height: 48),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: isWide ? 340 : double.infinity,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio:   isWide ? 1.5 : 2.5
              ),
              itemCount: AppStrings.skillCategories.length,
              itemBuilder: (_, i) => _SkillCard(
                data: AppStrings.skillCategories[i],
                index: i,
                visible: _visible,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class _SkillCard extends StatefulWidget {
  final Map<String, dynamic> data;
  final int index;
  final bool visible;

  const _SkillCard({
    required this.data,
    required this.index,
    required this.visible,
  });

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final skills = List<String>.from(widget.data['skills'] as List);

    return AnimatedOpacity(
      opacity: widget.visible ? 1 : 0,
      duration: Duration(milliseconds: 500 + widget.index * 100),
      child: AnimatedSlide(
        offset: widget.visible ? Offset.zero : const Offset(0, 0.15),
        duration: Duration(milliseconds: 500 + widget.index * 100),
        curve: Curves.easeOutCubic,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _hovered ? AppColors.bgTertiary : AppColors.bgSecondary,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _hovered
                    ? AppColors.accent.withOpacity(0.5)
                    : AppColors.border,
              ),
            ),
            
             
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              
                children: [
                  Row(
                    children: [
                      CustomText(
                       text: widget.data['icon'] as String,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CustomText(
                         text:  widget.data['category'] as String,
                          style: AppTextStyles.skillCategory.copyWith(
                            color: _hovered
                                ? AppColors.accentLight
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    child: Wrap(
                      clipBehavior: Clip.none,
                      spacing: 6,
                      runSpacing: 6,
                      children: skills.map((s) => _TechPill(label: s)).toList(),
                    ),
                  ),
                ],
              ),
          
          ),
        ),
      ),
    );
  }
}

class _TechPill extends StatelessWidget {
  final String label;
  const _TechPill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.tagBg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.tagBorder),
      ),
      child: CustomText(text: label, style: AppTextStyles.techTag),
    );
  }
}

// ── Shared Section Header ─────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

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
