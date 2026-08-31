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
    final isDesktop = context.isDesktop;
    final isTablet = context.isTablet;

    // ✅ عدد أعمدة يتدرج بدل قفزة واحدة من عمود لـ 3 أعمدة
    final crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);

    return VisibilityDetector(
      key: const Key('skills'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 64 : 24,
          vertical: isDesktop ? 100 : 64,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(title: 'Tech Stack'),
                const SizedBox(height: 12),
                Text(
                  'The tools and technologies I use to bring ideas to life.',
                  style: AppTextStyles.heroSummary.copyWith(fontSize: 15),
                ),
                const SizedBox(height: 48),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // ✅ crossAxisCount ثابت ومضبوط، مفيش infinity خالص
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: crossAxisCount == 1 ? 2.2 : 1.35,
                  ),
                  itemCount: AppStrings.skillCategories.length,
                  itemBuilder: (_, i) =>
                      _SkillCard(data: AppStrings.skillCategories[i], index: i, visible: _visible),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── كارت تصنيف واحد ──────────────────────────────────────────────────────

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
      duration: Duration(milliseconds: 450 + widget.index * 90),
      child: AnimatedSlide(
        offset: widget.visible ? Offset.zero : const Offset(0, 0.12),
        duration: Duration(milliseconds: 450 + widget.index * 90),
        curve: Curves.easeOutCubic,
        child: MouseRegion(
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: _hovered ? AppColors.bgTertiary : AppColors.bgSecondary,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _hovered ? AppColors.accent.withOpacity(0.5) : AppColors.border,
              ),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: AppColors.accent.withOpacity(0.12),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── الأيقونة في دايرة ملونة + العنوان ──────
                Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: _hovered ? AppColors.accentGlow : AppColors.bgTertiary,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _hovered ? AppColors.accent.withOpacity(0.4) : AppColors.border,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          widget.data['icon'] as String,
                          style: const TextStyle(fontSize: 19),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomText(
                        text: widget.data['category'] as String,
                        style: AppTextStyles.cardTitle.copyWith(
                          fontSize: 15.5,
                          color: _hovered ? AppColors.accentLight : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // ── خط فاصل رفيع بتدرج لوني ────────────────
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: _hovered ? 40 : 24,
                  height: 2.5,
                  decoration: BoxDecoration(
                    gradient: AppColors.accentGradient,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                const SizedBox(height: 18),

                // ── قائمة المهارات ─────────────────────────
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: skills.map((s) => TechPill(label: s)).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
