import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_strings.dart';
import 'package:portfolio/core/extensions/responsive.dart';
import 'package:portfolio/core/themes/app_colors.dart';
import 'package:portfolio/core/themes/app_text_styles.dart';
import 'package:portfolio/core/widgets/custom_text.dart';
import 'package:portfolio/core/widgets/tech_pill.dart';
import 'package:portfolio/features/home/presentation/views/widgets/section_header.dart';
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
        padding: EdgeInsets.symmetric(horizontal: isWide ? 64 : 24, vertical: 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: 'Tech Stack'),
            const SizedBox(height: 48),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              // ✅ التعديل: استخدمنا crossAxisCount بدل maxCrossAxisExtent: double.infinity
              gridDelegate: isWide
                  ? SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 340,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1,
                    )
                  : const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 2.5,
                    ),
              itemCount: AppStrings.skillCategories.length,
              itemBuilder: (_, i) =>
                  _SkillCard(data: AppStrings.skillCategories[i], index: i, visible: _visible),
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

  const _SkillCard({required this.data, required this.index, required this.visible});

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
                color: _hovered ? AppColors.accent.withOpacity(0.5) : AppColors.border,
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
                        text: widget.data['category'] as String,
                        style: AppTextStyles.skillCategory.copyWith(
                          color: _hovered ? AppColors.accentLight : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                SingleChildScrollView(
                  child: Wrap(
                    clipBehavior: Clip.none,
                    spacing: 6,
                    runSpacing: 6,
                    children: skills.map((s) => TechPill(label: s)).toList(),
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


// ── Shared Section Header ─────────────────────────────────────────────────────

