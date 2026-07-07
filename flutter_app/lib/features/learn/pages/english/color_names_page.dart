import 'package:gyan_jyoti/shared/widgets/app_asset_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../shared/providers/user_provider.dart';

class ColorNamesPage extends ConsumerStatefulWidget {
  const ColorNamesPage({super.key});

  @override
  ConsumerState<ColorNamesPage> createState() => _ColorNamesPageState();
}

class _ColorNamesPageState extends ConsumerState<ColorNamesPage> {
  final PageController _pageController = PageController();
  
  final List<Map<String, dynamic>> _pages = [
    {
      'colorName': 'RED', 
      'sentence': 'The Rocket is Red!', 
      'color': Colors.red, 
      'image': 'assets/colors_english/rocket.webp'
    },
    {
      'colorName': 'BLUE', 
      'sentence': 'The Diamond is Blue!', 
      'color': Colors.blue, 
      'image': 'assets/colors_english/diamond.webp'
    },
    {
      'colorName': 'GREEN', 
      'sentence': 'The Alien is Green!', 
      'color': Colors.green, 
      'image': 'assets/colors_english/alien.webp'
    },
    {
      'colorName': 'YELLOW', 
      'sentence': 'The Crown is Yellow!', 
      'color': Colors.amber, 
      'image': 'assets/colors_english/yellow.webp'
    },
    {
      'colorName': 'PURPLE', 
      'sentence': 'The Guitar is Purple!', 
      'color': Colors.purple, 
      'image': 'assets/colors_english/guitar.webp'
    },
    {
      'colorName': 'ORANGE', 
      'sentence': 'The Basketball is Orange!', 
      'color': Colors.orange, 
      'image': 'assets/colors_english/basketball.webp'
    },
    {
      'colorName': 'PINK', 
      'sentence': 'The Flower is Pink!', 
      'color': Colors.pink, 
      'image': 'assets/colors_english/flower.webp'
    },
    {
      'colorName': 'BROWN', 
      'sentence': 'The Coffee is Brown!', 
      'color': Colors.brown, 
      'image': 'assets/colors_english/coffee.webp'
    },
    {
      'colorName': 'BLACK', 
      'sentence': 'The Keyboard is Black!', 
      'color': Colors.black, 
      'image': 'assets/colors_english/keyboard.webp'
    },
    {
      'colorName': 'WHITE', 
      'sentence': 'The Snowflake is White!', 
      'color': Colors.white, 
      'image': 'assets/colors_english/snowflake.webp'
    },
    {
      'colorName': 'GREY', 
      'sentence': 'The Shield is Grey!', 
      'color': Colors.grey, 
      'image': 'assets/colors_english/shield.webp'
    },
  ];
  
  int _currentPageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _finishActivity() {
    final success = ref.read(userProvider.notifier).completeActivity('learn_Color Names', 15);
    if (success) {
      context.pushReplacement(AppRoutes.taskCompletion, extra: 15);
    } else {
      context.pop();
    }
  }

  void _nextPage() {
    if (_currentPageIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _finishActivity();
    }
  }

  void _previousPage() {
    if (_currentPageIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
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
          'My Colors Book',
          style: AppTextStyles.headlineMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                '${_currentPageIndex + 1} / ${_pages.length}',
                style: AppTextStyles.titleMedium.copyWith(color: Colors.black54),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
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
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.15),
                            blurRadius: 30,
                            spreadRadius: 5,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Top decorative color bar
                          Container(
                            height: 12,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                            ),
                          ),
                          
                          const Spacer(),
                          
                          // The Object Image / Icon
                          Container(
                            width: 220,
                            height: 220,
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: AppAssetImage(
  assetPath: pageData['image'] as String,
  fit: BoxFit.contain,
  fallback: Icon(
                                    Icons.image_not_supported_rounded,
                                    size: 80,
                                    color: color,
                                  ),
),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 50),
                          
                          // Text Area
                          Text(
                            pageData['colorName'] as String,
                            style: AppTextStyles.headlineLarge.copyWith(
                              color: color,
                              fontSize: 56,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 4,
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              pageData['sentence'] as String,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.titleMedium.copyWith(
                                color: Colors.black87,
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          
                          const Spacer(),
                          
                          // Bottom decorative bar
                          Container(
                            height: 12,
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.3),
                              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Navigation Controls
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Previous Button
                  IconButton(
                    onPressed: _currentPageIndex > 0 ? _previousPage : null,
                    iconSize: 48,
                    color: AppColors.primary,
                    disabledColor: Colors.grey.shade300,
                    icon: const Icon(Icons.arrow_circle_left_rounded),
                  ),
                  
                  // Next / Finish Button
                  GestureDetector(
                    onTap: _nextPage,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _currentPageIndex < _pages.length - 1 ? 'Next Page' : 'Finish Book',
                            style: AppTextStyles.titleMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Icons.menu_book_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ],
                      ),
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
