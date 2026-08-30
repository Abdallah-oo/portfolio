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
  final List<GlobalKey> _sectionKeys = List.generate(5, (_) => GlobalKey());
  int _activeIndex = 0;
  double _lastCheckedOffset = 0; // ✅ إضافة جديدة

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll); // ✅ اتغيرت من _updateActiveIndex لـ _onScroll
  }

  void _onScroll() {
    // ✅ دالة جديدة
    final offset = _scrollController.offset;
    // بنحسب بس لو الفرق أكتر من 24 بكسل، مش كل بكسل
    if ((offset - _lastCheckedOffset).abs() < 24) return;
    _lastCheckedOffset = offset;
    _updateActiveIndex();
  }

  void _scrollToSection(int index) {
    final ctx = _sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
    setState(() => _activeIndex = index);
  }

  void _updateActiveIndex() {
    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final position = box.localToGlobal(Offset.zero);
      if (position.dy <= 120) {
        if (_activeIndex != i) {
          setState(() => _activeIndex = i);
        }
        return;
      }
    }
    if (_activeIndex != 0) {
      setState(() => _activeIndex = 0);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll); // ✅ اتغيرت هنا كمان
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const SizedBox(height: 68),
              KeyedSubtree(
                key: _sectionKeys[0],
                child: HeroSection(onViewProjects: () => _scrollToSection(1)),
              ),
              KeyedSubtree(key: _sectionKeys[1], child: const ProjectsSection()),
              KeyedSubtree(key: _sectionKeys[2], child: const AboutSection()),
              KeyedSubtree(key: _sectionKeys[3], child: const SkillsSection()),

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
            scrollController: _scrollController, // ✅ إضافة جديدة
          ),
        ),
      ],
    );
  }
}
