import 'package:flutter/material.dart';
import 'package:portfolio/core/constants/app_strings.dart';
import 'package:portfolio/core/themes/app_colors.dart';
import 'package:portfolio/core/themes/app_text_styles.dart';
import 'package:portfolio/features/home/presentation/views/widgets/section_header.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _visible = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return VisibilityDetector(
      key: const Key('projects'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.0 && !_visible) {
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
            SectionHeader(title: 'Selected Work'),
            const SizedBox(height: 56),
            ...List.generate(AppStrings.projects.length, (i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: AnimatedOpacity(
                  opacity: _visible ? 1 : 0,
                  duration: Duration(milliseconds: 500 + i * 150),
                  child: AnimatedSlide(
                    offset: _visible ? Offset.zero : const Offset(0, 0.08),
                    duration: Duration(milliseconds: 500 + i * 150),
                    curve: Curves.easeOutCubic,
                    child: _ProjectCard(
                      project: AppStrings.projects[i],
                      isWide: isWide,
                      index: i,
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

// ── Project Card ─────────────────────────────────────────────────────────────

class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final bool isWide;
  final int index;

  const _ProjectCard({
    required this.project,
    required this.isWide,
    required this.index,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    final techs = List<String>.from(p['tech'] as List);
    final highlights = List<String>.from(p['highlights'] as List);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: _hovered ? AppColors.bgTertiary : AppColors.bgPrimary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? AppColors.accent.withOpacity(0.6)
                : AppColors.border,
            width: _hovered ? 1.5 : 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.1),
                    blurRadius: 40,
                    offset: const Offset(0, 12),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Full-width image ──────────────────────────
            _ProjectImage(p: p, hovered: _hovered),
            // ── Content ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(28),
              child: _ProjectContent(
                p: p,
                techs: techs,
                highlights: highlights,
                hovered: _hovered,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Project Image Block ───────────────────────────────────────────────────────

class _ProjectImage extends StatelessWidget {
  final Map<String, dynamic> p;
  final bool hovered;

  const _ProjectImage({required this.p, required this.hovered});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: SizedBox(
        width: double.infinity,

        child: Stack(
          clipBehavior: Clip.none,

          children: [
            // ── Image ─────────────────────────────────────
            AspectRatio(
              aspectRatio: 3.6 / 2,
              child: AnimatedScale(
                scale: hovered ? 1.03 : 1.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                child: Image.asset(
                  p['image'] as String,

                  errorBuilder: (_, _, _) => Container(
                    color: AppColors.bgTertiary,
                    child: Center(
                      child: Text(
                        p['number'] as String,
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.w800,
                          color: AppColors.accent.withOpacity(0.1),
                          fontFamily: 'FiraCode',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ── Bottom gradient ────────────────────────────
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 100,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.bgPrimary.withOpacity(0.9),
                    ],
                  ),
                ),
              ),
            ),

            // ── Number badge ───────────────────────────────
            Positioned(
              top: 16,
              left: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.55),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.accent.withOpacity(0.4)),
                ),
                child: Text(
                  p['number'] as String,
                  style: TextStyle(
                    fontFamily: 'FiraCode',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.accentLight,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),

            // ── YouTube button ─────────────────────────────
            if (p['youtubeUrl'] != null)
              Positioned(
                top: 12,
                right: 16,
                child: _YoutubePlayButton(url: p['youtubeUrl'] as String),
              ),
          ],
        ),
      ),
    );
  }
}
// ── YouTube Play Button ───────────────────────────────────────────────────────

class _YoutubePlayButton extends StatefulWidget {
  final String url;
  const _YoutubePlayButton({required this.url});

  @override
  State<_YoutubePlayButton> createState() => _YoutubePlayButtonState();
}

class _YoutubePlayButtonState extends State<_YoutubePlayButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: _hovered
                ? const Color(0xFFFF0000)
                : Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _hovered ? const Color(0xFFFF0000) : Colors.white24,
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: const Color(0xFFFF0000).withOpacity(0.4),
                      blurRadius: 16,
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.play_arrow_rounded, color: Colors.white, size: 18),
              SizedBox(width: 6),
              Text(
                'Watch Demo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// ── Project Content ───────────────────────────────────────────────────────────

class _ProjectContent extends StatelessWidget {
  final Map<String, dynamic> p;
  final List<String> techs;
  final List<String> highlights;
  final bool hovered;

  const _ProjectContent({
    required this.p,
    required this.techs,
    required this.highlights,
    required this.hovered,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ── Year badge ─────────────────────────────────────
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.accentGlow,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.accent.withOpacity(0.3)),
          ),
          child: Text(
            p['year'] as String,
            style: AppTextStyles.techTag.copyWith(
              color: AppColors.accentLight,
              fontSize: 11,
            ),
          ),
        ),

        const SizedBox(height: 14),

        // ── Title ──────────────────────────────────────────
        Text(p['title'] as String, style: AppTextStyles.cardTitle),
        const SizedBox(height: 4),
        Text(
          p['subtitle'] as String,
          style: AppTextStyles.cardSubtitle.copyWith(
            color: hovered ? AppColors.accentLight : null,
          ),
        ),

        const SizedBox(height: 16),

        // ── Divider ────────────────────────────────────────
        Container(
          width: 32,
          height: 2,
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),

        const SizedBox(height: 16),

        // ── Description ────────────────────────────────────
        Text(p['description'] as String, style: AppTextStyles.cardBody),

        const SizedBox(height: 20),

        // ── Highlights ─────────────────────────────────────
        ...highlights.map(
          (h) => Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      gradient: AppColors.accentGradient,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    h,
                    style: AppTextStyles.cardBody.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        // ── Tech pills ─────────────────────────────────────
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: techs.map((t) => _TechPill(label: t)).toList(),
        ),
      ],
    );
  }
}

// ── Tech Pill ─────────────────────────────────────────────────────────────────

class _TechPill extends StatelessWidget {
  final String label;
  const _TechPill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.tagBg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.tagBorder),
      ),
      child: Text(label, style: AppTextStyles.techTag),
    );
  }
}
