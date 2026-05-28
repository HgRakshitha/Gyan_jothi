import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/providers/user_provider.dart';
import '../../../../core/router/app_router.dart';

class LivingThingsBookPage extends ConsumerStatefulWidget {
  const LivingThingsBookPage({super.key});

  @override
  ConsumerState<LivingThingsBookPage> createState() => _LivingThingsBookPageState();
}

class _LivingThingsBookPageState extends ConsumerState<LivingThingsBookPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<Map<String, dynamic>> _pages = [
    {
      'title': 'Living Things',
      'desc': 'What makes something a living thing? Let\'s find out!',
      'color': Colors.green,
      'image': 'assets/living_things/tree.png',
    },
    {
      'title': 'They Breathe',
      'desc': 'Living things need air to breathe and stay alive.',
      'color': Colors.lightBlue,
      'image': 'assets/living_things/breath.png',
    },
    {
      'title': 'They Eat',
      'desc': 'Living things need food and water for energy.',
      'color': Colors.orange,
      'image': 'assets/living_things/eat.png',
    },
    {
      'title': 'They Grow',
      'desc': 'Living things start small and grow bigger over time.',
      'color': Colors.teal,
      'image': 'assets/living_things/grow.png',
    },
    {
      'title': 'They Move',
      'desc': 'Living things can move around on their own.',
      'color': Colors.purple,
      'image': 'assets/living_things/walk.png',
    },
    {
      'title': 'Examples',
      'desc': 'You, trees, birds, and fish are all living things!',
      'color': Colors.pink,
      'images': [
        'assets/living_things/bird.png',
        'assets/living_things/tree.png',
        'assets/living_things/fish.png',
      ],
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _finishActivity() {
    final success = ref.read(userProvider.notifier).completeActivity('learn_Living Things', 20);
    if (success) {
      context.pushReplacement(AppRoutes.taskCompletion, extra: 20);
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9), // Soft green background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Living Things',
          style: AppTextStyles.headlineMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: _finishActivity,
            child: Text(
              'Done',
              style: AppTextStyles.titleMedium.copyWith(color: AppColors.primary),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Page Indicator
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 10,
                    width: _currentPage == index ? 24 : 10,
                    decoration: BoxDecoration(
                      color: _currentPage == index 
                          ? _pages[index]['color'] as Color
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ),
            
            // Book Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final pageData = _pages[index];
                  final color = pageData['color'] as Color;
                  
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: color.withValues(alpha: 0.2), width: 8),
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.1),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          )
                        ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: pageData.containsKey('images')
                                  ? Wrap(
                                      alignment: WrapAlignment.center,
                                      spacing: 8,
                                      runSpacing: 8,
                                      children: (pageData['images'] as List<String>).map((img) => 
                                        Image.asset(img, width: 50, height: 50, fit: BoxFit.contain)
                                      ).toList(),
                                    )
                                  : Image.asset(
                                      pageData['image'] as String,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.contain,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Text(
                              pageData['title'] as String,
                              style: AppTextStyles.headlineLarge.copyWith(
                                fontSize: 36,
                                color: color,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              pageData['desc'] as String,
                              style: AppTextStyles.headlineMedium.copyWith(
                                fontSize: 24,
                                color: Colors.black54,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Navigation arrows
            Padding(
              padding: const EdgeInsets.only(bottom: 40, left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Prev
                  IconButton(
                    onPressed: _currentPage > 0 
                      ? () => _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut)
                      : null,
                    icon: const Icon(Icons.arrow_circle_left_rounded, size: 64),
                    color: _currentPage > 0 ? AppColors.primary : Colors.grey.shade300,
                  ),
                  // Next
                  IconButton(
                    onPressed: _currentPage < _pages.length - 1 
                      ? () => _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut)
                      : null,
                    icon: const Icon(Icons.arrow_circle_right_rounded, size: 64),
                    color: _currentPage < _pages.length - 1 ? AppColors.primary : Colors.grey.shade300,
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
