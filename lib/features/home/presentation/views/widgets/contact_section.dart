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
