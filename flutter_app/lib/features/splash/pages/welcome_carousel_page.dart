import 'package:flutter/material.dart';
import 'welcome_page.dart';
import 'welcome_bunny_page.dart';
import 'welcome_panda_page.dart';
import 'welcome_fox_page.dart';
import 'welcome_final_page.dart';

class WelcomeCarouselPage extends StatefulWidget {
  const WelcomeCarouselPage({super.key});

  @override
  State<WelcomeCarouselPage> createState() => _WelcomeCarouselPageState();
}

class _WelcomeCarouselPageState extends State<WelcomeCarouselPage> {
  final PageController _pageController = PageController();

  void _nextPage() {
    if (_pageController.page != null && _pageController.page!.round() < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(),
        children: [
          WelcomePage(onNext: _nextPage),
          WelcomeBunnyPage(onNext: _nextPage),
          WelcomePandaPage(onNext: _nextPage),
          WelcomeFoxPage(onNext: _nextPage),
          const WelcomeFinalPage(),
        ],
      ),
    );
  }
}
