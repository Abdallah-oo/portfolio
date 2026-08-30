import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/core/constants/app_strings.dart';
import 'package:portfolio/core/extensions/responsive.dart';
import 'package:portfolio/core/themes/app_colors.dart';
import 'package:portfolio/core/themes/app_text_styles.dart';
import 'package:portfolio/core/widgets/tech_pill.dart';
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
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('projects'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.05 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Column(
        children: [
          // ── Section intro (مقيّد بعرض الصفحة العادي) ──────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.isDesktop ? 64 : 24, vertical: 80),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedOpacity(
                opacity: _visible ? 1 : 0,
                duration: const Duration(milliseconds: 600),
                child: const SectionHeader(title: 'Selected Work'),
              ),
            ),
          ),

          // ── الكروت full-bleed (ماخده عرض الشاشة كله) ──────────
          ...List.generate(AppStrings.projects.length, (i) {
            return _ProjectStrip(project: AppStrings.projects[i], index: i, visible: _visible);
          }),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

// ── Full-width alternating strip ──────────────────────────────────────────

class _ProjectStrip extends StatefulWidget {
  final Map<String, dynamic> project;
  final int index;
  final bool visible;

  const _ProjectStrip({required this.project, required this.index, required this.visible});

  @override
  State<_ProjectStrip> createState() => _ProjectStripState();
}

class _ProjectStripState extends State<_ProjectStrip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;
    final isEven = widget.index.isEven;
    final bgColor = isEven ? AppColors.bgPrimary : AppColors.bgSecondary;

    final imageBlock = _ProjectImage(project: widget.project, hovered: _hovered);

    final contentBlock = _ProjectContent(project: widget.project, index: widget.index);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedOpacity(
        opacity: widget.visible ? 1 : 0,
        duration: Duration(milliseconds: 500 + (widget.index * 100).clamp(0, 600)),
        child: Container(
          width: double.infinity,
          color: bgColor,
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 64 : 24,
            vertical: isDesktop ? 72 : 40,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1300),
              child: isDesktop
                  ? IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: isEven
                            ? [
                                Expanded(flex: 6, child: imageBlock),
                                const SizedBox(width: 56),
                                Expanded(flex: 5, child: contentBlock),
                              ]
                            : [
                                Expanded(flex: 5, child: contentBlock),
                                const SizedBox(width: 56),
                                Expanded(flex: 6, child: imageBlock),
                              ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [imageBlock, const SizedBox(height: 28), contentBlock],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Image block ──────────────────────────────────────────────────────────

class _ProjectImage extends StatelessWidget {
  final Map<String, dynamic> project;
  final bool hovered;

  const _ProjectImage({required this.project, required this.hovered});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedScale(
              scale: hovered ? 1.05 : 1.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              child: Image.asset(
                project['image'] as String,
                fit: BoxFit.fill,
                cacheWidth: 900,
                errorBuilder: (_, _, _) => Container(
                  color: AppColors.bgTertiary,
                  child: Center(
                    child: Text(
                      project['number'] as String,
                      style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.w800,
                        color: AppColors.accent.withOpacity(0.15),
                        fontFamily: 'FiraCode',
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // تظليل خفيف دايم يخلي أي نص فوق الصورة واضح
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withOpacity(hovered ? 0.05 : 0.15), Colors.transparent],
                  stops: const [0.0, 0.4],
                ),
              ),
            ),

            // سنة المشروع — أعلى الصورة
            Positioned(top: 18, left: 18, child: _GlassBadge(text: project['year'] as String)),
          ],
        ),
      ),
    );
  }
}

class _GlassBadge extends StatelessWidget {
  final String text;
  const _GlassBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.45),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'FiraCode',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ── Content block (مع الرقم الشبحي في الخلفية) ─────────────────────────────

class _ProjectContent extends StatelessWidget {
  final Map<String, dynamic> project;
  final int index;

  const _ProjectContent({required this.project, required this.index});

  @override
  Widget build(BuildContext context) {
    final techs = List<String>.from(project['tech'] as List);
    final highlights = List<String>.from(project['highlights'] as List);
    final isDesktop = context.isDesktop;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ── الرقم الشبحي في الخلفية ──────────────────────
        if (isDesktop)
          Positioned(
            top: -30,
            right: -10,
            child: Text(
              project['number'] as String,
              style: TextStyle(
                fontFamily: 'FiraCode',
                fontSize: 130,
                fontWeight: FontWeight.w800,
                color: AppColors.border.withOpacity(0.5),
                height: 1,
              ),
            ),
          ),

        // ── المحتوى الفعلي فوق الرقم ─────────────────────
        Padding(
          padding: EdgeInsets.only(top: isDesktop ? 24 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project['title'] as String,
                style: (isDesktop ? AppTextStyles.sectionTitle : AppTextStyles.sectionTitleMobile)
                    .copyWith(fontSize: isDesktop ? 34 : 26),
              ),
              const SizedBox(height: 6),
              Text(
                project['subtitle'] as String,
                style: AppTextStyles.cardSubtitle.copyWith(fontSize: 15),
              ),

              const SizedBox(height: 18),
              Container(
                width: 40,
                height: 3,
                decoration: BoxDecoration(
                  gradient: AppColors.accentGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),

              Text(
                project['description'] as String,
                style: AppTextStyles.cardBody,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 18),

              ...highlights
                  .take(3)
                  .map(
                    (h) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
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

              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: techs.map((t) => TechPill(label: t)).toList(),
              ),

              const SizedBox(height: 28),

              // ── أزرار الأكشن ─────────────────────────
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  if (project['githubUrl'] != null)
                    _ActionButton(
                      icon: FontAwesomeIcons.github,
                      label: 'View Code',
                      url: project['githubUrl'] as String,
                      filled: false,
                    ),
                  if (project['youtubeUrl'] != null)
                    _ActionButton(
                      icon: FontAwesomeIcons.play,
                      label: 'Watch Demo',
                      url: project['youtubeUrl'] as String,
                      filled: true,
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── زرار أكشن عام (Code / Demo) ─────────────────────────────────────────────

class _ActionButton extends StatefulWidget {
  final FaIconData icon;
  final String label;
  final String url;
  final bool filled;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.url,
    required this.filled,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url), mode: LaunchMode.externalApplication),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
          decoration: BoxDecoration(
            gradient: widget.filled ? AppColors.accentGradient : null,
            color: widget.filled ? null : (_hovered ? AppColors.accentGlow : Colors.transparent),
            borderRadius: BorderRadius.circular(10),
            border: widget.filled
                ? null
                : Border.all(color: _hovered ? AppColors.accent : AppColors.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                widget.icon,
                size: 14,
                color: widget.filled ? Colors.white : AppColors.textPrimary,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: widget.filled ? Colors.white : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
