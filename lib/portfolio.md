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
//------------------------------------------------------------------
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
}//---------------------------------------------------------
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
State<HomeViewBody> createState() => \_HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
final ScrollController \_scrollController = ScrollController();
final List<GlobalKey> \_sectionKeys = List.generate(5, (_) => GlobalKey());
int \_activeIndex = 0;

@override
void initState() {
super.initState();
\_scrollController.addListener(\_updateActiveIndex);
}

void \_updateActiveIndex() {
for (int i = \_sectionKeys.length - 1; i >= 0; i--) {
final ctx = \_sectionKeys[i].currentContext;
if (ctx == null) continue;
final box = ctx.findRenderObject() as RenderBox?;
if (box == null) continue;
final position = box.localToGlobal(Offset.zero);
if (position.dy <= 120) {
if (\_activeIndex != i) {
setState(() => \_activeIndex = i);
}
return;
}
}
if (\_activeIndex != 0) {
setState(() => \_activeIndex = 0);
}
}

void \_scrollToSection(int index) {
final ctx = \_sectionKeys[index].currentContext;
if (ctx != null) {
Scrollable.ensureVisible(
ctx,
duration: const Duration(milliseconds: 700),
curve: Curves.easeInOutCubic,
);
}
setState(() => \_activeIndex = index);
}

@override
void dispose() {
\_scrollController.removeListener(\_updateActiveIndex);
\_scrollController.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
return Stack(
children: [
SingleChildScrollView(
controller: \_scrollController,
child: Column(
children: [
const SizedBox(height: 68),
KeyedSubtree(
key: \_sectionKeys[0],
child: HeroSection(onViewProjects: () => \_scrollToSection(1)),
),
KeyedSubtree(
key: \_sectionKeys[1],
child: const ProjectsSection(),
),
KeyedSubtree(key: \_sectionKeys[2], child: const AboutSection()),
KeyedSubtree(key: \_sectionKeys[3], child: const SkillsSection()),

              KeyedSubtree(key: _sectionKeys[4], child: const ContactSection()),
              const FooterWidget(),
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: NavbarWidget(
            sectionKeys: _sectionKeys,
            activeIndex: _activeIndex,
          ),
        ),
      ],
    );

}
}
//----------------------------------------------------------------
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
State<SkillsSection> createState() => \_SkillsSectionState();
}

class \_SkillsSectionState extends State<SkillsSection> {
bool \_visible = false;

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
                childAspectRatio:   isWide ? 1 : 2.5
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

class \_SkillCard extends StatefulWidget {
final Map<String, dynamic> data;
final int index;
final bool visible;

const \_SkillCard({
required this.data,
required this.index,
required this.visible,
});

@override
State<\_SkillCard> createState() => \_SkillCardState();
}

class \_SkillCardState extends State<\_SkillCard> {
bool \_hovered = false;

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
                  const SizedBox(height: 25),
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

class \_TechPill extends StatelessWidget {
final String label;
const \_TechPill({required this.label});

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

class \_SectionHeader extends StatelessWidget {
final String title;

const \_SectionHeader({required this.title});

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
//--------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:portfolio/core/themes/app_colors.dart';
import 'package:portfolio/core/themes/app_text_styles.dart';

class SectionHeader extends StatelessWidget {

final String title;

const SectionHeader({super.key, required this.title});

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
//------------------------------------------------------------------
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
State<ProjectsSection> createState() => \_ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
bool \_visible = false;
@override
void initState() {
super.initState();
WidgetsBinding.instance.addPostFrameCallback((_) {
if (mounted) setState(() => \_visible = true);
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

class \_ProjectCard extends StatefulWidget {
final Map<String, dynamic> project;
final bool isWide;
final int index;

const \_ProjectCard({
required this.project,
required this.isWide,
required this.index,
});

@override
State<\_ProjectCard> createState() => \_ProjectCardState();
}

class \_ProjectCardState extends State<\_ProjectCard> {
bool \_hovered = false;

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

class \_ProjectImage extends StatelessWidget {
final Map<String, dynamic> p;
final bool hovered;

const \_ProjectImage({required this.p, required this.hovered});

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
                  fit: BoxFit.cover,


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

class \_YoutubePlayButton extends StatefulWidget {
final String url;
const \_YoutubePlayButton({required this.url});

@override
State<\_YoutubePlayButton> createState() => \_YoutubePlayButtonState();
}

class \_YoutubePlayButtonState extends State<\_YoutubePlayButton> {
bool \_hovered = false;

@override
Widget build(BuildContext context) {
return MouseRegion(
onEnter: (_) => setState(() => \_hovered = true),
onExit: (_) => setState(() => \_hovered = false),
child: GestureDetector(
onTap: () => launchUrl(
Uri.parse(widget.url),
mode: LaunchMode.externalApplication,
),
child: AnimatedContainer(
duration: const Duration(milliseconds: 200),
padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
decoration: BoxDecoration(
color: \_hovered
? const Color(0xFFFF0000)
: Colors.black.withOpacity(0.7),
borderRadius: BorderRadius.circular(8),
border: Border.all(
color: \_hovered ? const Color(0xFFFF0000) : Colors.white24,
),
boxShadow: \_hovered
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

class \_ProjectContent extends StatelessWidget {
final Map<String, dynamic> p;
final List<String> techs;
final List<String> highlights;
final bool hovered;

const \_ProjectContent({
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

class \_TechPill extends StatelessWidget {
final String label;
const \_TechPill({required this.label});

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
//-----------------------------------------------------------------------
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/core/themes/app_colors.dart';
import 'package:portfolio/core/themes/app_text_styles.dart';

class NavbarWidget extends StatefulWidget {
final List<GlobalKey> sectionKeys;
final int activeIndex;

const NavbarWidget({super.key, required this.sectionKeys, required this.activeIndex});

@override
State<NavbarWidget> createState() => \_NavbarWidgetState();
}

class \_NavbarWidgetState extends State<NavbarWidget> {
final bool \_scrolled = false;
final List<String> \_labels = ['Home', 'Projects', 'About', 'Skills', 'Contact'];

void \_scrollToSection(int index) {
final ctx = widget.sectionKeys[index].currentContext;
if (ctx != null) {
Scrollable.ensureVisible(
ctx,
duration: const Duration(milliseconds: 700),
curve: Curves.easeInOutCubic,
);
}
}

@override
Widget build(BuildContext context) {
final isWide = MediaQuery.of(context).size.width > 768;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color.fromARGB(150, 0, 0, 0),
                Color.fromARGB(50, 0, 0, 0),
                Color.fromARGB(0, 0, 0, 0),
              ],
              stops: [0.0, 0.7, 1.0],
            ),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: _scrolled ? AppColors.bgSecondary.withOpacity(0.95) : Colors.transparent,
              border: _scrolled
                  ? const Border(bottom: BorderSide(color: AppColors.border, width: 0.5))
                  : null,
              boxShadow: _scrolled
                  ? [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20)]
                  : [],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isWide ? 64 : 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ShaderMask(
                    shaderCallback: (b) => AppColors.accentGradient.createShader(b),
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

                  if (isWide)
                    Row(
                      children: List.generate(_labels.length, (i) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 32),
                          child: _NavLink(
                            label: _labels[i],
                            active: widget.activeIndex == i,
                            onTap: () => _scrollToSection(i),
                          ),
                        );
                      }),
                    ).animate().fadeIn(delay: 200.ms, duration: 500.ms),

                  if (!isWide)
                    IconButton(
                      icon: const Icon(Icons.menu_rounded, color: AppColors.textSecondary),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: AppColors.bgSecondary,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (_) => _MobileMenu(
                            labels: _labels,
                            activeIndex: widget.activeIndex,
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
        ),
      ),
    );

}
}

class \_NavLink extends StatefulWidget {
final String label;
final bool active;
final VoidCallback onTap;

const \_NavLink({required this.label, required this.active, required this.onTap});

@override
State<\_NavLink> createState() => \_NavLinkState();
}

class \_NavLinkState extends State<\_NavLink> {
bool \_hovered = false;

@override
Widget build(BuildContext context) {
return MouseRegion(
onEnter: (_) => setState(() => \_hovered = true),
onExit: (_) => setState(() => \_hovered = false),
child: GestureDetector(
onTap: widget.onTap,
child: Column(
mainAxisSize: MainAxisSize.min,
children: [
Text(
widget.label,
style: widget.active || _hovered
? AppTextStyles.navLinkActive.copyWith(fontSize: 16)
: AppTextStyles.navLink.copyWith(fontSize: 16,color: const Color.fromARGB(255, 189, 190, 190)),
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

class \_MobileMenu extends StatelessWidget {
final List<String> labels;
final int activeIndex;
final void Function(int) onTap;

const \_MobileMenu({required this.labels, required this.activeIndex, required this.onTap});

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
//-----------------------------------------------------------------------
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
State<HeroSection> createState() => \_HeroSectionState();
}

class \_HeroSectionState extends State<HeroSection> {
int \_phraseIndex = 0;
String \_displayText = '';
bool \_typing = true;
Timer? \_timer;

final List<String> \_phrases = AppStrings.typewriterPhrases;

@override
void initState() {
super.initState();
\_startTypewriter();
}

void \_startTypewriter() {
int charIndex = 0;
final current = \_phrases[_phraseIndex];

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

void \_eraseText() {
if (!mounted) return;
final current = \_phrases[_phraseIndex];
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
\_timer?.cancel();
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

class \_BlinkingCursor extends StatefulWidget {
@override
State<\_BlinkingCursor> createState() => \_BlinkingCursorState();
}

class \_BlinkingCursorState extends State<\_BlinkingCursor>
with SingleTickerProviderStateMixin {
late AnimationController \_ctrl;

@override
void initState() {
super.initState();
\_ctrl = AnimationController(
vsync: this,
duration: const Duration(milliseconds: 600),
)..repeat(reverse: true);
}

@override
void dispose() {
\_ctrl.dispose();
super.dispose();
}

@override
Widget build(BuildContext context) {
return FadeTransition(
opacity: \_ctrl,
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

class \_PrimaryButton extends StatefulWidget {
final String label;
final VoidCallback onTap;
const \_PrimaryButton({required this.label, required this.onTap});

@override
State<\_PrimaryButton> createState() => \_PrimaryButtonState();
}

class \_PrimaryButtonState extends State<\_PrimaryButton> {
bool \_hovered = false;

@override
Widget build(BuildContext context) {
return MouseRegion(
onEnter: (_) => setState(() => \_hovered = true),
onExit: (_) => setState(() => \_hovered = false),
child: GestureDetector(
onTap: widget.onTap,
child: AnimatedContainer(
duration: const Duration(milliseconds: 200),
padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
decoration: BoxDecoration(
gradient: AppColors.accentGradient,
borderRadius: BorderRadius.circular(10),
boxShadow: \_hovered
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

class \_GhostButton extends StatefulWidget {
final String label;
final VoidCallback onTap;
const \_GhostButton({required this.label, required this.onTap});

@override
State<\_GhostButton> createState() => \_GhostButtonState();
}

class \_GhostButtonState extends State<\_GhostButton> {
bool \_hovered = false;

@override
Widget build(BuildContext context) {
return MouseRegion(
onEnter: (_) => setState(() => \_hovered = true),
onExit: (_) => setState(() => \_hovered = false),
child: GestureDetector(
onTap: widget.onTap,
child: AnimatedContainer(
duration: const Duration(milliseconds: 200),
padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
decoration: BoxDecoration(
color: \_hovered ? AppColors.accentGlow : Colors.transparent,
borderRadius: BorderRadius.circular(10),
border: Border.all(
color: \_hovered ? AppColors.accent : AppColors.border,
width: 1.5,
),
),
child: Text(widget.label, style: AppTextStyles.buttonSecondary),
),
),
);
}
}

class \_SocialIcon extends StatefulWidget {
final FaIconData icon;
final String url;
const \_SocialIcon({required this.icon, required this.url});

@override
State<\_SocialIcon> createState() => \_SocialIconState();
}

class \_SocialIconState extends State<\_SocialIcon> {
bool \_hovered = false;

@override
Widget build(BuildContext context) {
return MouseRegion(
onEnter: (_) => setState(() => \_hovered = true),
onExit: (_) => setState(() => \_hovered = false),
child: GestureDetector(
onTap: () => launchUrl(
Uri.parse(widget.url),
mode: LaunchMode.externalApplication,
),
child: AnimatedContainer(
duration: const Duration(milliseconds: 200),
padding: const EdgeInsets.all(10),
decoration: BoxDecoration(
color: \_hovered ? AppColors.accentGlow : AppColors.bgTertiary,
borderRadius: BorderRadius.circular(10),
border: Border.all(
color: \_hovered ? AppColors.accent : AppColors.border,
),
),
child: FaIcon(
widget.icon,
size: 18,
color: \_hovered ? AppColors.accent : AppColors.textSecondary,
),
),
),
);
}
}

//---------------------------------------------------------------------------------
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
State<ContactSection> createState() => \_ContactSectionState();
}

class \_ContactSectionState extends State<ContactSection> {
bool \_visible = false;

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
                  ?  GridView.builder(

              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 4,
              ),
              itemCount: _contactItems.length,
              itemBuilder: (context,int index){
                return _ContactCard(item: _contactItems[index]);
              }
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

static final List<Map<String, dynamic>> \_contactItems = [
{
'icon': FontAwesomeIcons.envelope,
'label': 'Email',
'value': AppStrings.email,
'url': 'mailto:${AppStrings.email}',
},
{
'icon': FontAwesomeIcons.github,
'label': 'GitHub',
'value': '@Abdallah-oo',
'url': AppStrings.githubUrl,
},
{
'icon': FontAwesomeIcons.linkedin,
'label': 'LinkedIn',
'value': '@abdallah-oo',
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

class \_ContactCard extends StatefulWidget {
final Map<String, dynamic> item;
const \_ContactCard({required this.item});

@override
State<\_ContactCard> createState() => \_ContactCardState();
}

class \_ContactCardState extends State<\_ContactCard> {
bool \_hovered = false;

@override
Widget build(BuildContext context) {
return MouseRegion(
onEnter: (_) => setState(() => \_hovered = true),
onExit: (_) => setState(() => \_hovered = false),
child: GestureDetector(
onTap: () => launchUrl(Uri.parse(widget.item['url'] as String)),
child: AnimatedContainer(
duration: const Duration(milliseconds: 200),
padding: const EdgeInsets.all(20),
decoration: BoxDecoration(
color: \_hovered ? AppColors.bgTertiary : AppColors.bgSecondary,
borderRadius: BorderRadius.circular(14),
border: Border.all(
color: \_hovered
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
                    widget.item['icon']! ,
                    color: AppColors.accent,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
'© 2026 All rights reserved by Abdallah Ahmed',
style: AppTextStyles.cardBody
.copyWith(fontSize: 13, color: AppColors.textTertiary),
),
),
);
}
}
//--------------------------------------------------------------------
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
State<AboutSection> createState() => \_AboutSectionState();
}

class \_AboutSectionState extends State<AboutSection> {
bool \_visible = false;

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

class \_LeftContent extends StatelessWidget {
final bool visible;

const \_LeftContent({required this.visible});

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

class \_RightStats extends StatelessWidget {
final bool isWide;
final bool visible;
const \_RightStats({required this.visible, required this.isWide});

final List<Map<String, String>> \_stats = const [
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

class \_StatCard extends StatelessWidget {
final String value;
final String label;

const \_StatCard({required this.value, required this.label});

@override
Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
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
    );

}
}
//------------------------------------------------------------------------
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/core/themes/app_text_styles.dart';

class CustomText extends StatelessWidget {
const CustomText({
super.key,
required this.text,
this.style,
this.align,
this.maxLines,
this.minFontSize,
});

final String text;
final TextStyle? style;
final TextAlign? align;
final int? maxLines;
final double? minFontSize;

@override
Widget build(BuildContext context) {
return AutoSizeText(
text,
textAlign: align ?? TextAlign.start,
style: style ?? AppTextStyles.cardBody,
maxLines: maxLines ?? 1,
minFontSize: minFontSize ?? 9,
overflow: TextOverflow.ellipsis,
);
}
}
//-----------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/themes/app_colors.dart';

class AppTheme {
AppTheme.\_();

static ThemeData get dark => ThemeData(
brightness: Brightness.dark,
scaffoldBackgroundColor: AppColors.bgPrimary,
colorScheme: const ColorScheme.dark(
primary: AppColors.accent,
secondary: AppColors.secondary,
surface: AppColors.bgSecondary,
),
textTheme: TextStyleTextTheme(ThemeData.dark().textTheme),
useMaterial3: true,
);
}
//-------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/core/themes/app_colors.dart';

class AppTextStyles {
AppTextStyles.\_();

static TextStyle get heroName => TextStyle(
fontSize: 56,
fontWeight: FontWeight.w800,
color: AppColors.textPrimary,
height: 1.1,
letterSpacing: -1.5,
);

static TextStyle get heroNameMobile => TextStyle(
fontSize: 36,
fontWeight: FontWeight.w800,
color: AppColors.textPrimary,
height: 1.1,
letterSpacing: -1.0,
);

static TextStyle get heroRole => TextStyle(
fontSize: 18,
fontWeight: FontWeight.w500,
color: AppColors.accent,
letterSpacing: 0.5,
);

static TextStyle get heroSummary => TextStyle(
fontSize: 16,
fontWeight: FontWeight.w400,
color: AppColors.textSecondary,
height: 1.7,
);

static TextStyle get sectionTitle => TextStyle(
fontSize: 36,
fontWeight: FontWeight.w700,
color: AppColors.textPrimary,
letterSpacing: -0.5,
);

static TextStyle get sectionTitleMobile => TextStyle(
fontSize: 26,
fontWeight: FontWeight.w700,
color: AppColors.textPrimary,
letterSpacing: -0.3,
);

static TextStyle get sectionLabel => TextStyle(
fontSize: 13,
fontWeight: FontWeight.w500,
color: AppColors.accent,
letterSpacing: 2.0,
);

static TextStyle get cardTitle => TextStyle(
fontSize: 20,
fontWeight: FontWeight.w700,
color: AppColors.textPrimary,
);

static TextStyle get cardSubtitle => TextStyle(
fontSize: 14,
fontWeight: FontWeight.w500,
color: AppColors.accent,
);

static TextStyle get cardBody => TextStyle(
fontSize: 14,
fontWeight: FontWeight.w400,
color: AppColors.textSecondary,
height: 1.65,
);

static TextStyle get techTag => TextStyle(
fontSize: 12,
fontWeight: FontWeight.w500,
color: AppColors.accentLight,
);

static TextStyle get navLink => TextStyle(
fontSize: 14,
fontWeight: FontWeight.w500,
color: AppColors.textSecondary,
);

static TextStyle get navLinkActive => TextStyle(
fontSize: 14,
fontWeight: FontWeight.w600,
color: AppColors.accent,
);

static TextStyle get buttonPrimary => TextStyle(
fontSize: 14,
fontWeight: FontWeight.w600,
color: Colors.white,
letterSpacing: 0.3,
);

static TextStyle get buttonSecondary => TextStyle(
fontSize: 14,
fontWeight: FontWeight.w600,
color: AppColors.accent,
letterSpacing: 0.3,
);

static TextStyle get projectNumber => TextStyle(
fontSize: 48,
fontWeight: FontWeight.w700,
color: AppColors.accentGlow,
);

static TextStyle get skillCategory => TextStyle(
fontSize: 13,
fontWeight: FontWeight.w600,
color: AppColors.textSecondary,
letterSpacing: 0.5,
);
}
//-----------------------------------------------------------------------------
import 'package:flutter/material.dart';

class AppColors {
AppColors.\_();

// ── Backgrounds ──────────────────────────────────────────────
static const Color bgPrimary = Color(0xFF0B0E1A); // deep navy-black
static const Color bgSecondary = Color(0xFF111827); // card surface
static const Color bgTertiary = Color(0xFF1C2333); // hover / elevated

// ── Accents ──────────────────────────────────────────────────
static const Color accent = Color(0xFF6C8EF5); // soft indigo-blue
static const Color accentLight = Color(0xFF93AAF8); // lighter tint
static const Color accentGlow = Color(0x336C8EF5); // glow / bg overlay

static const Color secondary = Color(0xFF8B5CF6); // soft violet
static const Color secondaryGlow = Color(0x338B5CF6);

// ── Text ─────────────────────────────────────────────────────
static const Color textPrimary = Color(0xFFE8EDF5); // near-white
static const Color textSecondary = Color(0xFF8A95A8); // muted
static const Color textTertiary = Color(0xFF4A5568); // very muted

// ── Borders ──────────────────────────────────────────────────
static const Color border = Color(0xFF1E2840);
static const Color borderHover = Color(0xFF6C8EF5);

// ── Skill tag backgrounds ─────────────────────────────────────
static const Color tagBg = Color(0xFF161D2F);
static const Color tagBorder = Color(0xFF2A3554);

// ── Gradient ─────────────────────────────────────────────────
static const LinearGradient accentGradient = LinearGradient(
colors: [accent, secondary],
begin: Alignment.centerLeft,
end: Alignment.centerRight,
);

static const LinearGradient heroGradient = LinearGradient(
colors: [Color(0xFF0B0E1A), Color(0xFF131929)],
begin: Alignment.topCenter,
end: Alignment.bottomCenter,
);
}
//------------------------------------------------------------------------
import 'dart:math' as math;
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
double get screenWidth => MediaQuery.of(this).size.width;
double get screenHeight => MediaQuery.of(this).size.height;

double responsiveWidth({
double? screen,
required double percentage,
required double min,
required double max,
}) {
return math.min(math.max((screen ?? screenWidth) \* percentage, min), max);
}

double responsiveHeight({
double? screen,
required double percentage,
required double min,
required double max,
}) {
return math.min(math.max((screen ?? screenHeight) \* percentage, min), max);
}
}
//---------------------------------------------------------------
class Solution {

static double findMaxAverage(List<int> nums, int k) {
int sum = 0;
for (int i = 0; i < k; i++) {
sum += nums[i];
}

    int maxSum = sum;


    for (int i = k; i < nums.length; i++) {
      sum += nums[i] - nums[i - k];
      if (sum > maxSum) maxSum = sum;
    }

    return maxSum / k;

}
}
//------------------------------------------------------
class AppStrings {
AppStrings.\_();

// ── Personal ─────────────────────────────────────────────────
static const String name = 'Abdallah Ahmed';
static const String role = 'Flutter Developer';
static const String roleTag = '< Flutter Developer />';
static const String email = 'abdallah81786417@gmail.com';
static const String phone = '+201210075879';
static const String location = 'Cairo, Egypt';
static const String githubUrl = 'https://github.com/Abdallah-oo';
static const String linkedinUrl = 'https://www.linkedin.com/in/abdallah-oo/';
static const String cvLink =
'https://drive.google.com/drive/folders/1VmPaF4XjhP-nrpnegGMP-ZudC14UAtFV?hl=ar';

static const String summary =
'Flutter Developer with 1+ year of experience building '
'production-quality Android & iOS applications. Proficient in '
'Clean Architecture, BLoC/Cubit, REST APIs, and Supabase.';

// ── Hero typewriter phrases ───────────────────────────────────
static const List<String> typewriterPhrases = [
'Flutter Developer',
'Mobile App Builder',
'Clean Architecture Fan',
'BLoC / Cubit Expert',
'UI/UX Enthusiast',
];

// ── Education ────────────────────────────────────────────────
static const String university = 'Zagazig University';
static const String degree = 'B.Sc. Computers & Information — IT';
static const String gpa = 'GPA: 3.15 / 4.0 — Very Good';
static const String eduPeriod = 'Sep 2021 – Sep 2025';
static const String gradProject =
'Graduation Project: Eco-Friendly Food Waste Tracker (Flutter) — Grade A+';

// ── Projects ─────────────────────────────────────────────────
static const List<Map<String, dynamic>> projects = [
{
'number': '01',
'title': 'Chattr',
'subtitle': 'Real-Time Chat Application',
'year': '2026',
'image': 'assets/images/projects_covers/Chat.jpg',
'youtubeUrl': 'https://youtu.be/OTLd1MyU0y8',
'githubUrl': 'https://github.com/Abdallah-oo/Chattr',
'description':
'Feature-First Clean Architecture chat app with live private & group '
'messaging powered by Supabase Realtime. Supports voice messages, '
'image sharing, offline caching (Hive), pagination, and role-based '
'group management with optimistic UI updates.',
'tech': ['Flutter', 'Supabase', 'BLoC/Cubit', 'Hive', 'Clean Arch'],
'highlights': [
'Real-time messaging with Supabase Realtime',
'Offline-first with Hive caching',
'Voice messages & image sharing',
'Role-based group management',
],
},
{
'number': '02',
'title': 'Hungry Time',
'subtitle': 'Food Delivery App',
'year': '2026',
'image': 'assets/images/projects_covers/Hungry.jpg',
'youtubeUrl': 'https://youtu.be/ZyhmN2Mzk8k',
'githubUrl': 'https://github.com/Abdallah-oo/hungry_time',
'description':
'End-to-end food ordering experience built with Clean Architecture '
'and a reusable Dio-based API layer with JWT auth, interceptors, '
'and centralized error handling.',
'tech': ['Flutter', 'REST APIs', 'Dio', 'BLoC/Cubit', 'JWT'],
'highlights': [
'Dio API layer with JWT & interceptors',
'Guest checkout & payment flow',
'Meal customization & cart management',
'Real-time order tracking',
],
},
{
'number': '03',
'title': 'Sooq',
'subtitle': 'Grocery Shopping App',
'year': '2025',
'image': 'assets/images/projects_covers/Sooq.jpg',
'youtubeUrl': 'https://youtu.be/cgoHK1NfNtM',
'githubUrl': 'https://github.com/Abdallah-oo/sooq',
'description':
'Grocery shopping app with Clean Architecture, global BLoC state '
'for cart & favorites, live search, category filtering, promo codes, '
'image cropping, skeleton loading, and smooth page transitions.',
'tech': ['Flutter', 'Supabase', 'BLoC/Cubit', 'Clean Arch'],
'highlights': [
'Live search & category filtering',
'Global BLoC cart & favorites',
'Promo codes & image cropping',
'Skeleton loading & smooth transitions',
],
},
{
'number': '04',
'title': 'ToneDust',
'subtitle': 'Music Player App',
'year': '2025',
'image': 'assets/images/projects_covers/ToneDust.jpg',
'youtubeUrl': 'https://youtube.com/shorts/1zVvhi8nO0g?feature=share',
'githubUrl': 'https://github.com/Abdallah-oo/music_app',
'description':
'Music player app focused on custom animations: playback-synced '
'vinyl rotation, staggered transitions, animated auth flows, and '
'a glassmorphism navigation UI.',
'tech': ['Flutter', 'Supabase Auth', 'BLoC/Cubit', 'Animations'],
'highlights': [
'Playback-synced vinyl rotation animation',
'Staggered & glassmorphism UI',
'Animated authentication flows',
'Custom navigation animations',
],
},
{
'number': '05',
'title': 'Cafe App',
'subtitle': 'Flutter Drink Ordering App',
'year': '2025',
'image': 'assets/images/projects_covers/CafeApp.jpg',
'youtubeUrl': 'https://youtube.com/shorts/TjaAW1uiXGE?feature=share',
'githubUrl': 'https://github.com/Abdallah-oo/cafe_app',
'description':
'Production-quality drink ordering app built from scratch with no '
'third-party UI kits. Features a fully custom design system, '
'composite-key cart, real-time search & filter, and a glassmorphism '
'checkout sheet.',
'tech': ['Flutter', 'Provider', 'Custom Animations', 'Clean Arch'],
'highlights': [
'Composite-key cart (product + size) with live badge count',
'Glassmorphism checkout sheet with DraggableScrollableSheet',
'Staggered list entrance & Hero animations',
'Real-time search + category filter in a single computed getter',
],
},
{
'number': '06',
'title': 'Runway',
'subtitle': 'Fashion E-Commerce App',
'year': '2025',
'image': 'assets/images/projects_covers/Runway.jpg',
'youtubeUrl': 'https://youtube.com/shorts/j9Pl-9rG5GE?feature=share',
'githubUrl': 'https://github.com/Abdallah-oo/Runway',
'description':
'Sleek fashion shopping app with a full-screen video banner, '
'parallax image carousel, DraggableScrollableSheet product details, '
'complete checkout & order flow, and a dark-themed design system '
'with gold accents powered by Supabase.',
'tech': ['Flutter', 'Supabase', 'BLoC/Cubit', 'Clean Arch'],
'highlights': [
'Full-screen video banner & SVG splash animation',
'Parallax carousel with color & size selectors',
'Complete order flow: address, payment & confirmation',
'Dark theme with gold accents & Playfair Display typography',
],
},
{
'number': '07',
'title': 'Fashion App',
'subtitle': 'Full-Featured Fashion E-Commerce',
'year': '2025',
'image': 'assets/images/projects_covers/Fashion.jpg',
'youtubeUrl': 'https://youtube.com/shorts/KuQkPCRzgSc?feature=share',
'githubUrl': 'https://github.com/Abdallah-oo/fashion_app',
'description':
'Sleek fashion shopping app with complete onboarding, authentication, '
'live product browsing from Supabase, and a full checkout flow including '
'address & payment management. Dark-themed design with gold accents and '
'Playfair Display typography.',
'tech': ['Flutter', 'Supabase', 'BLoC/Cubit', 'Clean Arch'],
'highlights': [
'Complete auth flow: onboarding, login & sign-up via Supabase',
'Full checkout: address, credit card & order confirmation',
'Dark theme with gold accents & Playfair Display typography',
'Custom snackbar system & responsive layout across all screen sizes',
],
},
];
// ── Skills ───────────────────────────────────────────────────
static const List<Map<String, dynamic>> skillCategories = [
{
'category': 'Mobile',
'icon': '📱',
'skills': ['Flutter', 'Dart', 'Android', 'iOS', 'Responsive UI'],
},
{
'category': 'State Management',
'icon': '⚙️',
'skills': ['BLoC / Cubit', 'Provider'],
},
{
'category': 'Architecture',
'icon': '🏛️',
'skills': ['Clean Architecture', 'MVVM', 'SOLID', 'Repository Pattern'],
},
{
'category': 'Backend & APIs',
'icon': '🔌',
'skills': ['REST APIs', 'Dio', 'Supabase', 'Firebase', 'Firebase FCM'],
},
{
'category': 'Storage',
'icon': '💾',
'skills': ['Hive', 'Shared Preferences', 'Flutter Secure Storage'],
},
{
'category': 'Tools',
'icon': '🛠️',
'skills': [
'Git / GitHub',
'Postman',
'Figma',
'GitHub Actions',
'Fastlane',
],
},
];
}
//-----------------------------------------------------------------
