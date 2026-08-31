import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/core/extensions/responsive.dart';
import 'package:portfolio/core/themes/app_colors.dart';
import 'package:portfolio/core/themes/app_text_styles.dart';

class NavbarWidget extends StatefulWidget {
  final List<GlobalKey> sectionKeys;
  final int activeIndex;
  final ScrollController scrollController; // ✅ إضافة جديدة

  const NavbarWidget({
    super.key,
    required this.sectionKeys,
    required this.activeIndex,
    required this.scrollController, // ✅ إضافة جديدة
  });

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  bool _scrolled = false; // ✅ بقت قابلة للتغيير (شلنا final)
  final List<String> _labels = ['Home', 'Projects', 'About', 'Skills', 'Contact'];

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll); // ✅ إضافة جديدة
  }

  void _onScroll() {
    // ✅ دالة جديدة
    final scrolled = widget.scrollController.offset > 10;
    if (scrolled != _scrolled) {
      setState(() => _scrolled = scrolled);
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll); // ✅ إضافة جديدة
    super.dispose();
  }

  void _scrollToSection(int index) {
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
    final isWide = context.isDesktop;

    // ✅ التعديل: لو مش scrolled، من غير BackdropFilter خالص
    if (!_scrolled) {
      return _buildNavContent(context, isWide);
    }

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: _buildNavContent(context, isWide),
      ),
    );
  }

  // ✅ استخرجنا محتوى الـ navbar لدالة منفصلة عشان نستخدمها في الحالتين
  Widget _buildNavContent(BuildContext context, bool isWide) {
    return Container(



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
            padding: EdgeInsets.symmetric(vertical:isWide? 5:0),
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
                      '< AA / >',
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
        );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavLink({required this.label, required this.active, required this.onTap});

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
                  ? AppTextStyles.navLinkActive.copyWith(fontSize: 16)
                  : AppTextStyles.navLink.copyWith(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 189, 190, 190),
                    ),
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

  const _MobileMenu({required this.labels, required this.activeIndex, required this.onTap});

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
