import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_strings.dart';
import 'package:portfolio/core/extensions/responsive.dart';
import 'package:portfolio/core/themes/app_colors.dart';
import 'package:portfolio/core/themes/app_text_styles.dart';
import 'package:portfolio/core/widgets/custom_text.dart';
import 'package:portfolio/features/home/presentation/views/widgets/section_header.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isWide = context.screenWidth > 900;

    return VisibilityDetector(
      key: const Key('about'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        width: double.infinity,
        color: AppColors.bgSecondary,
        padding: EdgeInsets.symmetric(
          horizontal: isWide ? 64 : 24,
          vertical: 80,
        ),
        child: isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 5, child: _LeftContent(visible: _visible)),
                  const SizedBox(width: 64),
                  Expanded(
                    flex: 4,
                    child: _RightStats(visible: _visible, isWide: isWide),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _LeftContent(visible: _visible),
                  const SizedBox(height: 48),
                  _RightStats(visible: _visible, isWide: isWide),
                ],
              ),
      ),
    );
  }
}

class _LeftContent extends StatelessWidget {
  final bool visible;

  const _LeftContent({required this.visible});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: const Duration(milliseconds: 600),
      child: AnimatedSlide(
        offset: visible ? Offset.zero : const Offset(-0.1, 0),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: 'About Me'),
            const SizedBox(height: 28),
            Text(
              "I'm a Flutter Developer from Cairo, Egypt, passionate about building "
              "beautiful, performant mobile and web applications. With 1+ year of "
              "dedicated self-study and hands-on projects, I've built production-quality "
              "apps using Clean Architecture and BLoC/Cubit.",
              style: AppTextStyles.heroSummary,
            ),
            const SizedBox(height: 16),
            Text(
              "I believe great software is built on solid architecture, clean code, "
              "and attention to detail. Every project I build reflects my commitment "
              "to delivering real value through technology.",
              style: AppTextStyles.heroSummary,
            ),
            const SizedBox(height: 28),

            // Education card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.bgPrimary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.school_outlined,
                        color: AppColors.accent,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text('Education', style: AppTextStyles.cardSubtitle),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppStrings.university,
                    style: AppTextStyles.cardTitle.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(AppStrings.degree, style: AppTextStyles.cardBody),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.gpa,
                    style: AppTextStyles.techTag.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.eduPeriod,
                    style: AppTextStyles.cardBody.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.accentGlow,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.accent.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: AppColors.accent,
                          size: 14,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: CustomText(
                            maxLines: 2,
                            text: AppStrings.gradProject,
                            style: AppTextStyles.techTag.copyWith(fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RightStats extends StatelessWidget {
  final bool isWide;
  final bool visible;
  const _RightStats({required this.visible, required this.isWide});

  final List<Map<String, String>> _stats = const [
    {'value': '1+', 'label': 'Year of Flutter\nExperience'},
    {'value': '4', 'label': 'Production-Quality\nProjects'},
    {'value': '3.15', 'label': 'GPA at\nZagazig University'},
    {'value': 'A+', 'label': 'Graduation\nProject Grade'},
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: const Duration(milliseconds: 700),
      child: AnimatedSlide(
        offset: visible ? Offset.zero : const Offset(0.1, 0),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutCubic,
        child: Column(
          children: [
            // ── Profile Image ──────────────────────────────
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColors.accentGradient,
              ),
              padding: const EdgeInsets.all(3),
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.bgPrimary,
                ),
                padding: const EdgeInsets.all(3),
                child: CircleAvatar(
                  radius: 90,
                  backgroundImage: AssetImage(
                    'assets/images/profile/profile.jpg',
                  ),
                  backgroundColor: AppColors.bgSecondary,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ── Stats Grid ─────────────────────────────────
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isWide ? (3 / 2.7) : (3 / 2),
              ),
              itemCount: _stats.length,
              itemBuilder: (_, i) => _StatCard(
                value: _stats[i]['value']!,
                label: _stats[i]['label']!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {


    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Container(
        color: Colors.red,
        child: SizedBox(
          height: context.screenWidth * 0.06,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ShaderMask(
                  shaderCallback: (b) => AppColors.accentGradient.createShader(b),
                  blendMode: BlendMode.srcIn,
                  child: CustomText(
                    text: value,
                    style: TextStyle(
                      fontSize:100,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                     
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            
                Expanded(
                  child: CustomText(
                    maxLines: 2,
                    text: label,
                    style: AppTextStyles.cardBody.copyWith(
                      fontSize: 12,
                     
                    ),
                  ),
                ),
             
            ],
          ),
        ),
      ),
    );
  }
}
