import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/constants/app_strings.dart';
import 'package:portfolio/core/themes/app_colors.dart';
import 'package:portfolio/core/themes/app_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onViewProjects;
  const HeroSection({super.key, required this.onViewProjects});

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
      if (!mounted) {
        t.cancel();
        return;
      }
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
      if (!mounted) {
        t.cancel();
        return;
      }
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
          // Name
          Text(
                AppStrings.name,
                style: isWide
                    ? AppTextStyles.heroName
                    : AppTextStyles.heroNameMobile,
              )
              .animate()
              .fadeIn(delay: 200.ms, duration: 700.ms)
              .slideY(begin: 0.3, end: 0),

          const SizedBox(height: 12),

          // Typewriter role
          Row(
            children: [
              Text(_displayText, style: AppTextStyles.heroRole),
              _BlinkingCursor(),
            ],
          ).animate().fadeIn(delay: 400.ms, duration: 500.ms),

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
                    onTap: widget.onViewProjects,
                  ),
                  _GhostButton(
                    label: 'Download CV',
                    onTap: () => launchUrl(Uri.parse(AppStrings.cvLink)),
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
          ).animate().fadeIn(delay: 1000.ms, duration: 500.ms),
        ],
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
                      offset: const Offset(0, 6),
                    ),
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
        onTap: () => launchUrl(
          Uri.parse(widget.url),
          mode: LaunchMode.externalApplication,
        ),
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
