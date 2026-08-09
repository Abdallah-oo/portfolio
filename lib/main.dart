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
