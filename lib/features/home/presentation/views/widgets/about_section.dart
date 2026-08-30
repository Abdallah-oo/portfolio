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
    final isDesktop = context.isDesktop;

    return VisibilityDetector(
      key: const Key('about'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        width: double.infinity,
        color: AppColors.bgSecondary,
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 64 : 24,
          vertical: isDesktop ? 100 : 64,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1300),
            child: isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 6, child: _LeftContent(visible: _visible)),
                      const SizedBox(width: 72),
                      Expanded(flex: 4, child: _RightProfile(visible: _visible)),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _RightProfile(visible: _visible),
                      const SizedBox(height: 48),
                      _LeftContent(visible: _visible),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

// ── العمود الأيسر: النص + الإحصائيات + التعليم ─────────────────────────────

class _LeftContent extends StatelessWidget {
  final bool visible;
  const _LeftContent({required this.visible});

  static const List<Map<String, String>> _stats = [
    {'value': '1+', 'label': 'Years of\nExperience'},
    {'value': '7', 'label': 'Production-Quality\nProjects'},
    {'value': '3.15', 'label': 'GPA at\nZagazig University'},
    {'value': 'A+', 'label': 'Graduation\nProject Grade'},
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: const Duration(milliseconds: 600),
      child: AnimatedSlide(
        offset: visible ? Offset.zero : const Offset(-0.08, 0),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'About Me'),
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

            const SizedBox(height: 44),

            // ── شريط الإحصائيات بفواصل رأسية ──────────────
            _StatsStrip(stats: _stats),

            const SizedBox(height: 44),

            // ── كارت التعليم بشكل Timeline ──────────────────
            const _EducationTimeline(),
          ],
        ),
      ),
    );
  }
}

// ── شريط الإحصائيات ──────────────────────────────────────────────────────

class _StatsStrip extends StatelessWidget {
  final List<Map<String, String>> stats;
  const _StatsStrip({required this.stats});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // ✅ Wrap بدل Row/Grid: لو المساحة ضاقت، العنصر بينزل سطر جديد بدل overflow
      spacing: 0,
      runSpacing: 24,
      children: List.generate(stats.length * 2 - 1, (i) {
        // كل عنصر زوجي = رقم، كل عنصر فردي = فاصل رأسي
        if (i.isEven) {
          final stat = stats[i ~/ 2];
          return SizedBox(
            width: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (b) => AppColors.accentGradient.createShader(b),
                  blendMode: BlendMode.srcIn,
                  child: Text(
                    stat['value']!,
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontFamily: 'FiraCode',
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(stat['label']!, style: AppTextStyles.cardBody.copyWith(fontSize: 12.5)),
              ],
            ),
          );
        } else {
          return Container(
            width: 1,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            color: AppColors.border,
          );
        }
      }),
    );
  }
}

// ── كارت التعليم بشكل Timeline ───────────────────────────────────────────

class _EducationTimeline extends StatelessWidget {
  const _EducationTimeline();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ── الخط الرأسي: بيمتد تلقائيًا بارتفاع الـ Stack ──
        Positioned(
          left: 5,
          top: 16,
          bottom: 4,
          child: Container(width: 1.5, color: AppColors.border),
        ),

        // ── المحتوى ─────────────────────────────────
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.school_outlined, color: AppColors.accent, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'Education',
                    style: AppTextStyles.techTag.copyWith(
                      color: AppColors.accent,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(AppStrings.university, style: AppTextStyles.cardTitle.copyWith(fontSize: 17)),
              const SizedBox(height: 4),
              Text(AppStrings.degree, style: AppTextStyles.cardBody),
              const SizedBox(height: 4),
              Wrap(
                spacing: 10,
                runSpacing: 4,
                children: [
                  Text(
                    AppStrings.gpa,
                    style: AppTextStyles.techTag.copyWith(color: AppColors.secondary),
                  ),
                  Text('•', style: AppTextStyles.cardBody.copyWith(color: AppColors.textTertiary)),
                  Text(
                    AppStrings.eduPeriod,
                    style: AppTextStyles.cardBody.copyWith(color: AppColors.textTertiary),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.accentGlow,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.accent.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star_rounded, color: AppColors.accent, size: 15),
                    const SizedBox(width: 8),
                    Flexible(
                      child: CustomText(
                        maxLines: 2,
                        text: AppStrings.gradProject,
                        style: AppTextStyles.techTag.copyWith(fontSize: 11.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ── النقطة (الدوت) فوق الخط ──────────────────
        Positioned(
          left: 0,
          top: 4,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              gradient: AppColors.accentGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.5),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── العمود الأيمن: الصورة الشخصية بإطار مميز ────────────────────────────────

class _RightProfile extends StatelessWidget {
  final bool visible;
  const _RightProfile({required this.visible});

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;
    final size = isDesktop ? 300.0 : 220.0;

    return AnimatedOpacity(
      opacity: visible ? 1 : 0,
      duration: const Duration(milliseconds: 700),
      child: AnimatedSlide(
        offset: visible ? Offset.zero : const Offset(0.08, 0),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutCubic,
        child: Center(
          child: SizedBox(
            // ✅ مساحة إضافية حوالين الصورة عشان البادچ العائم ميعملش overflow
            width: size + 40,
            height: size + 60,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                // ── زوايا ديكورية (زي viewfinder) ─────────
                Positioned(top: 10, child: _CornerFrame(size: size)),

                // ── الصورة نفسها ──────────────────────────
                Positioned(
                  top: 30,
                  child: Container(
                    width: size - 40,
                    height: size - 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border, width: 1),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/profile/profile.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // ── بادچ "Available for Work" عائم ────────
                Positioned(bottom: 10, child: const _AvailabilityBadge()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CornerFrame extends StatelessWidget {
  final double size;
  const _CornerFrame({required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _CornerPainter(color: AppColors.accent)),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final Color color;
  _CornerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const len = 28.0;

    // الزاوية العلوية اليسرى
    canvas.drawLine(const Offset(0, 0), const Offset(len, 0), paint);
    canvas.drawLine(const Offset(0, 0), const Offset(0, len), paint);

    // الزاوية العلوية اليمنى
    canvas.drawLine(Offset(size.width, 0), Offset(size.width - len, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, len), paint);

    // الزاوية السفلية اليسرى
    canvas.drawLine(Offset(0, size.height), Offset(len, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(0, size.height - len), paint);

    // الزاوية السفلية اليمنى
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width - len, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height), Offset(size.width, size.height - len), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AvailabilityBadge extends StatefulWidget {
  const _AvailabilityBadge();

  @override
  State<_AvailabilityBadge> createState() => _AvailabilityBadgeState();
}

class _AvailabilityBadgeState extends State<_AvailabilityBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeTransition(
            opacity: _ctrl,
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(color: Color(0xFF4ADE80), shape: BoxShape.circle),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Available for Work',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
