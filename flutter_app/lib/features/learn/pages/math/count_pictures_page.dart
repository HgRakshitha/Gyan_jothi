import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/providers/user_provider.dart';
import '../../../../core/router/app_router.dart';

class CountPicturesPage extends ConsumerStatefulWidget {
  const CountPicturesPage({super.key});

  @override
  ConsumerState<CountPicturesPage> createState() => _CountPicturesPageState();
}

class _CountPicturesPageState extends ConsumerState<CountPicturesPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<Map<String, dynamic>> _pages = [
    {'num': 1, 'word': 'One', 'color': Colors.red, 'image': 'assets/icons/quiz/slice_appple.png'},
    {'num': 2, 'word': 'Two', 'color': Colors.blue, 'image': 'assets/icons/quiz/banana.png'},
    {'num': 3, 'word': 'Three', 'color': Colors.green, 'image': 'assets/icons/quiz/carrot.png'},
    {'num': 4, 'word': 'Four', 'color': Colors.amber, 'image': 'assets/icons/quiz/milk.png'},
    {'num': 5, 'word': 'Five', 'color': Colors.purple, 'image': 'assets/icons/quiz/animals_set2/dog.png'},
    {'num': 6, 'word': 'Six', 'color': Colors.orange, 'image': 'assets/icons/quiz/animals_set2/tiger.png'},
    {'num': 7, 'word': 'Seven', 'color': Colors.pink, 'image': 'assets/icons/quiz/animals_set2/cow.png'},
    {'num': 8, 'word': 'Eight', 'color': Colors.brown, 'image': 'assets/icons/quiz/animals_set2/monkey.png'},
    {'num': 9, 'word': 'Nine', 'color': Colors.teal, 'image': 'assets/icons/quiz/animals_set2/elephant.png'},
    {'num': 10, 'word': 'Ten', 'color': Colors.indigo, 'image': 'assets/icons/quiz/color_pallete.png'},
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _finishActivity() {
    final success = ref.read(userProvider.notifier).completeActivity('learn_Count with Pictures', 20);
    if (success) {
      context.pushReplacement(AppRoutes.taskCompletion, extra: 20);
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Count with Pictures',
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
                  final number = pageData['num'] as int;
                  
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
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              '$number',
                              style: AppTextStyles.headlineLarge.copyWith(
                                fontSize: 80,
                                color: color,
                                height: 1,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Text(
                              pageData['word'] as String,
                              style: AppTextStyles.headlineMedium.copyWith(
                                fontSize: 28,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 20),
                            
                            // Grid of objects to count
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Wrap(
                                spacing: number > 6 ? 12 : 20,
                                runSpacing: number > 6 ? 12 : 20,
                                alignment: WrapAlignment.center,
                                children: List.generate(
                                  number,
                                  (i) => Image.asset(
                                    pageData['image'] as String,
                                    width: number > 6 ? 60 : 90,
                                    height: number > 6 ? 60 : 90,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
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
