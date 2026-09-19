import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_strings.dart';
import 'package:portfolio/core/extensions/responsive.dart';
import 'package:portfolio/core/themes/app_colors.dart';
import 'package:portfolio/core/themes/app_text_styles.dart';
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

                LayoutBuilder(
                  builder: (context, constraints) {
                    const spacing = 20.0;
                    final columns = constraints.maxWidth >= 900
                        ? 3
                        : (constraints.maxWidth >= 560 ? 2 : 1);

                    final categories = AppStrings.skillCategories;
                    final rows = <List<Map<String, dynamic>>>[];
                    for (var i = 0; i < categories.length; i += columns) {
                      rows.add(
                        categories.sublist(
                          i,
                          (i + columns > categories.length) ? categories.length : i + columns,
                        ),
                      );
                    }

                    return Column(
                      children: List.generate(rows.length, (rowIndex) {
                        final rowItems = rows[rowIndex];

                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: rowIndex == rows.length - 1 ? 0 : spacing,
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                for (var i = 0; i < rowItems.length; i++) ...[
                                  if (i != 0) const SizedBox(width: spacing),
                                  Expanded(
                                    child: _SkillCard(
                                      data: rowItems[i],
                                      index: rowIndex * columns + i,
                                      visible: _visible,
                                    ),
                                  ),
                                ],
                                if (rowItems.length < columns)
                                  for (var i = 0; i < columns - rowItems.length; i++) ...[
                                    const SizedBox(width: spacing),
                                    const Expanded(child: SizedBox()),
                                  ],
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ],
            ),
          ),
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
            width: double.infinity,
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
                      child: Text(
                        widget.data['category'] as String,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.cardTitle.copyWith(
                          fontSize: 15.5,
                          color: _hovered ? AppColors.accentLight : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

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

                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: skills.map((s) => TechPill(label: s)).toList(),
                ),

                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
