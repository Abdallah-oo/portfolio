import 'package:flutter/material.dart';
import 'package:portfolio/core/themes/app_theme.dart';
import 'package:portfolio/features/home/presentation/views/home_view.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abdallah Ahmed — Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const HomeView(),
    );
  }
}
//---------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:portfolio/features/home/presentation/views/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeViewBody(),
    );
  }
}//------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:portfolio/features/home/presentation/views/widgets/about_section.dart';
import 'package:portfolio/features/home/presentation/views/widgets/contact_section.dart';
import 'package:portfolio/features/home/presentation/views/widgets/hero_section.dart';
import 'package:portfolio/features/home/presentation/views/widgets/navbar_widget.dart';
import 'package:portfolio/features/home/presentation/views/widgets/projects_section.dart';
import 'package:portfolio/features/home/presentation/views/widgets/skills_section.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {

  final ScrollController _scrollController = ScrollController();

  // Keys for scroll-to-section
  final List<GlobalKey> _sectionKeys = List.generate(5, (_) => GlobalKey());

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Stack(
        children: [
          // ── Main scroll body ─────────────────────────────────────
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Top spacer for navbar
                const SizedBox(height: 68),

                // Hero
                KeyedSubtree(
                  key: _sectionKeys[0],
                  child: const HeroSection(),
                ),

                // About
                KeyedSubtree(
                  key: _sectionKeys[1],
                  child: const AboutSection(),
                ),

                // Skills
                KeyedSubtree(
                  key: _sectionKeys[2],
                  child: const SkillsSection(),
                ),

                // Projects
                KeyedSubtree(
                  key: _sectionKeys[3],
                  child: const ProjectsSection(),
                ),

                // Contact
                KeyedSubtree(
                  key: _sectionKeys[4],
                  child: const ContactSection(),
                ),

                const FooterWidget(),
              ],
            ),
          ),

          // ── Sticky Navbar ────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavbarWidget(sectionKeys: _sectionKeys),
          ),
        ],
      );
  }
}//--------------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_strings.dart';
import 'package:portfolio/core/themes/app_colors.dart';
import 'package:portfolio/core/themes/app_text_styles.dart';
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
    final isWide = MediaQuery.of(context).size.width > 900;

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
                  Expanded(flex: 4, child: _RightStats(visible: _visible)),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _LeftContent(visible: _visible),
                  const SizedBox(height: 48),
                  _RightStats(visible: _visible),
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
            SectionHeader( title: 'About Me'),
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
                      const Icon(Icons.school_outlined,
                          color: AppColors.accent, size: 18),
                      const SizedBox(width: 8),
                      Text('Education',
                          style: AppTextStyles.cardSubtitle),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(AppStrings.university,
                      style: AppTextStyles.cardTitle
                          .copyWith(fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(AppStrings.degree,
                      style: AppTextStyles.cardBody),
                  const SizedBox(height: 4),
                  Text(AppStrings.gpa,
                      style: AppTextStyles.techTag
                          .copyWith(color: AppColors.secondary)),
                  const SizedBox(height: 4),
                  Text(AppStrings.eduPeriod,
                      style: AppTextStyles.cardBody
                          .copyWith(color: AppColors.textTertiary)),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.accentGlow,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: AppColors.accent.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded,
                            color: AppColors.accent, size: 14),
                        const SizedBox(width: 6),
                        Text(
                          AppStrings.gradProject,
                          style: AppTextStyles.techTag
                              .copyWith(fontSize: 11),
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
  final bool visible;
  const _RightStats({required this.visible});

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
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                  backgroundColor: AppColors.bgSecondary,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // ── Stats Grid ─────────────────────────────────
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.3,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (b) =>
                AppColors.accentGradient.createShader(b),
            blendMode: BlendMode.srcIn,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                height: 1,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTextStyles.cardBody
                .copyWith(fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }
}


//----------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/constants/app_strings.dart';
import 'package:portfolio/core/themes/app_colors.dart';
import 'package:portfolio/core/themes/app_text_styles.dart';
import 'package:portfolio/features/home/presentation/views/widgets/section_header.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';




class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 768;

    return VisibilityDetector(
      key: const Key('contact'),
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
            AnimatedOpacity(
              opacity: _visible ? 1 : 0,
              duration: const Duration(milliseconds: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionHeader( title: "Let's Talk"),
                  const SizedBox(height: 16),
                  Text(
                    "I'm open to Junior Flutter roles and exciting projects. "
                    "Feel free to reach out!",
                    style: AppTextStyles.heroSummary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            AnimatedOpacity(
              opacity: _visible ? 1 : 0,
              duration: const Duration(milliseconds: 700),
              child: isWide
                  ? Row(
                      children: _contactItems
                          .map((c) => Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: _ContactCard(item: c),
                                ),
                              ))
                          .toList(),
                    )
                  : Column(
                      children: _contactItems
                          .map(
                            (c) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _ContactCard(item: c),
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  static final List<Map<String, dynamic>> _contactItems = [
    {
      'icon': FontAwesomeIcons.envelope,
      'label': 'Email',
      'value': AppStrings.email,
      'url': 'mailto:${AppStrings.email}',
    },
    {
      'icon': FontAwesomeIcons.github,
      'label': 'GitHub',
      'value': 'github.com/abdallah',
      'url': AppStrings.githubUrl,
    },
    {
      'icon': FontAwesomeIcons.linkedin,
      'label': 'LinkedIn',
      'value': 'linkedin.com/in/abdallah',
      'url': AppStrings.linkedinUrl,
    },
    {
      'icon': FontAwesomeIcons.phone,
      'label': 'Phone',
      'value': AppStrings.phone,
      'url': 'tel:${AppStrings.phone}',
    },
  ];
}

class _ContactCard extends StatefulWidget {
  final Map<String, dynamic> item;
  const _ContactCard({required this.item});

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.item['url'] as String)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
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
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.accentGlow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: FaIcon(
                    widget.item['icon'] as IconData,
                    color: AppColors.accent,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.item['label'] as String,
                      style: AppTextStyles.skillCategory),
                  const SizedBox(height: 3),
                  Text(
                    widget.item['value'] as String,
                    style: AppTextStyles.cardBody.copyWith(fontSize: 13),
                  ),
                ],
              ),
              const Spacer(),
              Icon(Icons.arrow_forward_ios_rounded,
                  color: _hovered
                      ? AppColors.accent
                      : AppColors.textTertiary,
                  size: 14),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: Center(
        child: Text(
          '© 2026 Abdallah Ahmed — Built with Flutter 💙',
          style: AppTextStyles.cardBody
              .copyWith(fontSize: 13, color: AppColors.textTertiary),
        ),
      ),
    );
  }
}
//----------------------------------------------------------
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/constants/app_strings.dart';
import 'package:portfolio/core/themes/app_colors.dart';
import 'package:portfolio/core/themes/app_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';




class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  int _phraseIndex = 0;
  String _displayText = '';
  bool _typing = true;
  Timer? _timer;

  final List<String> _phrases = AppStrings.typewriterPhrases;

  @override
  void initState() {
    super.initState();
    _startTypewriter();
  }

  void _startTypewriter() {
    int charIndex = 0;
    final current = _phrases[_phraseIndex];

    _timer = Timer.periodic(const Duration(milliseconds: 80), (t) {
      if (!mounted) { t.cancel(); return; }
      if (_typing) {
        if (charIndex <= current.length) {
          setState(() => _displayText = current.substring(0, charIndex));
          charIndex++;
        } else {
          t.cancel();
          Future.delayed(const Duration(milliseconds: 1800), _eraseText);
        }
      }
    });
  }

  void _eraseText() {
    if (!mounted) return;
    final current = _phrases[_phraseIndex];
    int charIndex = current.length;

    _timer = Timer.periodic(const Duration(milliseconds: 40), (t) {
      if (!mounted) { t.cancel(); return; }
      if (charIndex >= 0) {
        setState(() => _displayText = current.substring(0, charIndex));
        charIndex--;
      } else {
        t.cancel();
        setState(() {
          _phraseIndex = (_phraseIndex + 1) % _phrases.length;
          _typing = true;
        });
        _startTypewriter();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w > 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? 64 : 24,
        vertical: isWide ? 120 : 80,
      ),
      decoration: const BoxDecoration(gradient: AppColors.heroGradient),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting tag
          _TagChip(label: '👋 Hello World')
              .animate()
              .fadeIn(duration: 600.ms)
              .slideY(begin: 0.3, end: 0),

          const SizedBox(height: 24),

          // Name
          Text(
            AppStrings.name,
            style:
                isWide ? AppTextStyles.heroName : AppTextStyles.heroNameMobile,
          )
              .animate()
              .fadeIn(delay: 200.ms, duration: 700.ms)
              .slideY(begin: 0.3, end: 0),

          const SizedBox(height: 12),

          // Typewriter role
          Row(
            children: [
              Text(
                _displayText,
                style: AppTextStyles.heroRole,
              ),
              _BlinkingCursor(),
            ],
          )
              .animate()
              .fadeIn(delay: 400.ms, duration: 500.ms),

          const SizedBox(height: 24),

          // Summary
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 580),
            child: Text(
              AppStrings.summary,
              style: AppTextStyles.heroSummary,
            ),
          )
              .animate()
              .fadeIn(delay: 600.ms, duration: 600.ms)
              .slideY(begin: 0.2, end: 0),

          const SizedBox(height: 40),

          // Buttons
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              _PrimaryButton(
                label: 'View Projects',
                onTap: () {},
              ),
              _GhostButton(
                label: 'Download CV',
                onTap: () => launchUrl(Uri.parse(AppStrings.githubUrl)),
              ),
            ],
          )
              .animate()
              .fadeIn(delay: 800.ms, duration: 500.ms)
              .slideY(begin: 0.2, end: 0),

          const SizedBox(height: 48),

          // Social links
          Row(
            children: [
              _SocialIcon(
                icon: FontAwesomeIcons.github,
                url: AppStrings.githubUrl,
              ),
              const SizedBox(width: 20),
              _SocialIcon(
                icon: FontAwesomeIcons.linkedin,
                url: AppStrings.linkedinUrl,
              ),
              const SizedBox(width: 20),
              _SocialIcon(
                icon: FontAwesomeIcons.envelope,
                url: 'mailto:${AppStrings.email}',
              ),
            ],
          )
              .animate()
              .fadeIn(delay: 1000.ms, duration: 500.ms),
        ],
      ),
    );
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _TagChip extends StatelessWidget {
  final String label;
  const _TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.accentGlow,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accent.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: AppTextStyles.techTag.copyWith(
          color: AppColors.accentLight,
          fontSize: 13,
        ),
      ),
    );
  }
}

class _BlinkingCursor extends StatefulWidget {
  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _ctrl,
      child: Container(
        width: 2,
        height: 22,
        margin: const EdgeInsets.only(left: 2),
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(1),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.onTap});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(10),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                        color: AppColors.accent.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 6))
                  ]
                : [],
          ),
          child: Text(widget.label, style: AppTextStyles.buttonPrimary),
        ),
      ),
    );
  }
}

class _GhostButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _GhostButton({required this.label, required this.onTap});

  @override
  State<_GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<_GhostButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.accentGlow : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered ? AppColors.accent : AppColors.border,
              width: 1.5,
            ),
          ),
          child: Text(widget.label, style: AppTextStyles.buttonSecondary),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  const _SocialIcon({required this.icon, required this.url});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.accentGlow : AppColors.bgTertiary,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered ? AppColors.accent : AppColors.border,
            ),
          ),
          child: FaIcon(
            widget.icon,
            size: 18,
            color: _hovered ? AppColors.accent : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
//---------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/core/themes/app_colors.dart';
import 'package:portfolio/core/themes/app_text_styles.dart';


class NavbarWidget extends StatefulWidget {
  final List<GlobalKey> sectionKeys;

  const NavbarWidget({super.key, required this.sectionKeys});

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  int _activeIndex = 0;
  bool _scrolled = false;

  final List<String> _labels = ['Home', 'About', 'Skills', 'Projects', 'Contact'];

  void _scrollToSection(int index) {
    final ctx = widget.sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
    setState(() => _activeIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 768;

    return NotificationListener<ScrollNotification>(
      onNotification: (n) {
        if (n is ScrollUpdateNotification) {
          setState(() => _scrolled = n.metrics.pixels > 20);
        }
        return false;
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: _scrolled
              ? AppColors.bgSecondary.withOpacity(0.95)
              : Colors.transparent,
          border: _scrolled
              ? const Border(
                  bottom: BorderSide(color: AppColors.border, width: 0.5))
              : null,
          boxShadow: _scrolled
              ? [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20)]
              : [],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? 64 : 20,
            vertical: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              ShaderMask(
                shaderCallback: (b) =>
                    AppColors.accentGradient.createShader(b),
                child: Text(
                  '< AA />',
                  style: TextStyle(
                    fontFamily: 'FiraCode',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ).animate().fadeIn(duration: 500.ms),

              // Nav links (desktop)
              if (isWide)
                Row(
                  children: List.generate(_labels.length, (i) {
                    final active = _activeIndex == i;
                    return Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: _NavLink(
                        label: _labels[i],
                        active: active,
                        onTap: () => _scrollToSection(i),
                      ),
                    );
                  }),
                ).animate().fadeIn(delay: 200.ms, duration: 500.ms),

              // Mobile menu icon
              if (!isWide)
                IconButton(
                  icon: const Icon(Icons.menu_rounded,
                      color: AppColors.textSecondary),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: AppColors.bgSecondary,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (_) => _MobileMenu(
                        labels: _labels,
                        activeIndex: _activeIndex,
                        onTap: (i) {
                          Navigator.pop(context);
                          _scrollToSection(i);
                        },
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavLink(
      {required this.label, required this.active, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: widget.active || _hovered
                  ? AppTextStyles.navLinkActive
                  : AppTextStyles.navLink,
            ),
            const SizedBox(height: 3),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: widget.active ? 20 : (_hovered ? 10 : 0),
              height: 2,
              decoration: BoxDecoration(
                gradient: AppColors.accentGradient,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final List<String> labels;
  final int activeIndex;
  final void Function(int) onTap;

  const _MobileMenu(
      {required this.labels,
      required this.activeIndex,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          ...List.generate(labels.length, (i) {
            final active = activeIndex == i;
            return ListTile(
              onTap: () => onTap(i),
              title: Text(
                labels[i],
                style: active
                    ? AppTextStyles.navLinkActive.copyWith(fontSize: 16)
                    : AppTextStyles.navLink.copyWith(fontSize: 16),
              ),
              trailing: active
                  ? Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.accent,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            );
          }),
        ],
      ),
    );
  }
}
//-------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_strings.dart';
import 'package:portfolio/core/themes/app_colors.dart';
import 'package:portfolio/core/themes/app_text_styles.dart';
import 'package:portfolio/features/home/presentation/views/widgets/section_header.dart';
import 'package:visibility_detector/visibility_detector.dart';



class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return VisibilityDetector(
      key: const Key('projects'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           SectionHeader( title: 'Selected Work'),
            const SizedBox(height: 56),
            ...List.generate(AppStrings.projects.length, (i) {
              final project = AppStrings.projects[i];
              final isEven = i % 2 == 0;
              return Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: AnimatedOpacity(
                  opacity: _visible ? 1 : 0,
                  duration: Duration(milliseconds: 600 + i * 150),
                  child: AnimatedSlide(
                    offset: _visible ? Offset.zero : const Offset(0, 0.1),
                    duration: Duration(milliseconds: 600 + i * 150),
                    curve: Curves.easeOutCubic,
                    child: _ProjectCard(
                      project: project,
                      accentLeft: isEven,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final bool accentLeft;

  const _ProjectCard({required this.project, required this.accentLeft});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;


  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 768;
    final p = widget.project;
    final techs = List<String>.from(p['tech'] as List);
    final highlights = List<String>.from(p['highlights'] as List);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.bgTertiary : AppColors.bgPrimary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? AppColors.accent.withOpacity(0.5)
                : AppColors.border,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.08),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  )
                ]
              : [],
        ),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _NumberBlock(number: p['number'] as String),
                    const SizedBox(width: 28),
                    Expanded(child: _CardContent(p: p, techs: techs, highlights: highlights)),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _NumberBlock(number: p['number'] as String),
                    const SizedBox(height: 16),
                    _CardContent(p: p, techs: techs, highlights: highlights),
                  ],
                ),
        ),
      ),
    );
  }
}

class _NumberBlock extends StatelessWidget {
  final String number;
  const _NumberBlock({required this.number});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (b) => LinearGradient(
        colors: [AppColors.accent.withOpacity(0.15), Colors.transparent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(b),
      child: Text(
        number,
        style: AppTextStyles.projectNumber,
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final Map<String, dynamic> p;
  final List<String> techs;
  final List<String> highlights;

  const _CardContent(
      {required this.p, required this.techs, required this.highlights});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p['title'] as String, style: AppTextStyles.cardTitle),
                  const SizedBox(height: 4),
                  Text(p['subtitle'] as String, style: AppTextStyles.cardSubtitle),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.tagBg,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.tagBorder),
              ),
              child: Text(
                p['year'] as String,
                style: AppTextStyles.techTag
                    .copyWith(color: AppColors.textSecondary),
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Description
        Text(p['description'] as String, style: AppTextStyles.cardBody),

        const SizedBox(height: 20),

        // Highlights
        ...highlights.map(
          (h) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 7),
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(h,
                      style: AppTextStyles.cardBody
                          .copyWith(color: AppColors.textSecondary)),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Tech pills
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: techs
              .map(
                (t) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.accentGlow,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: AppColors.accent.withOpacity(0.3)),
                  ),
                  child: Text(t, style: AppTextStyles.techTag),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
//--------------------------------------------------------------------
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
//------------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_strings.dart';
import 'package:portfolio/core/themes/app_colors.dart';
import 'package:portfolio/core/themes/app_text_styles.dart';
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
    final isWide = MediaQuery.of(context).size.width > 768;

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
            _SectionHeader(label: '// skills', title: 'Tech Stack'),
            const SizedBox(height: 48),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: isWide ? 340 : double.infinity,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isWide ? 1.8 : 2.2,
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

  const _SkillCard(
      {required this.data, required this.index, required this.visible});

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
                    Text(widget.data['icon'] as String,
                        style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Text(
                      widget.data['category'] as String,
                      style: AppTextStyles.skillCategory.copyWith(
                        color: _hovered
                            ? AppColors.accentLight
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: skills
                      .map((s) => _TechPill(label: s))
                      .toList(),
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
      child: Text(label, style: AppTextStyles.techTag),
    );
  }
}

// ── Shared Section Header ─────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String label;
  final String title;

  const _SectionHeader({required this.label, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.sectionLabel),
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
//--------------------------------------------------------------------------------
