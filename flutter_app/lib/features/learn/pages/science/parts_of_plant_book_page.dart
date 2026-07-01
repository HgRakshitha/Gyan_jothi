import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/providers/user_provider.dart';
import '../../../../core/router/app_router.dart';

class PartsOfPlantBookPage extends ConsumerStatefulWidget {
  const PartsOfPlantBookPage({super.key});

  @override
  ConsumerState<PartsOfPlantBookPage> createState() => _PartsOfPlantBookPageState();
}

class _PlantPartItem {
  final String title;
  final String desc;
  final String imagePath;
  final Color color;
  final IconData fallbackIcon;

  const _PlantPartItem({
    required this.title,
    required this.desc,
    required this.imagePath,
    required this.color,
    required this.fallbackIcon,
  });
}

class _PartsOfPlantBookPageState extends ConsumerState<PartsOfPlantBookPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_PlantPartItem> _pages = [
    const _PlantPartItem(
      title: 'What is a Plant?',
      desc: 'Plants are living things that grow in the earth. They need soil, water, and sunlight to live and grow big!',
      imagePath: 'assets/plants/plant.png',
      color: Colors.green,
      fallbackIcon: Icons.local_florist_rounded,
    ),
    const _PlantPartItem(
      title: 'The Roots',
      desc: 'Roots grow deep down under the soil. They hold the plant tight and drink water and nutrients from the ground!',
      imagePath: 'assets/plants/root.png',
      color: Colors.brown,
      fallbackIcon: Icons.grass_rounded,
    ),
    const _PlantPartItem(
      title: 'The Stem',
      desc: 'The stem stands tall above the ground. It is like a straw, carrying water and food to all parts of the plant!',
      imagePath: 'assets/plants/stem.png',
      color: Colors.lightGreen,
      fallbackIcon: Icons.vertical_distribute_rounded,
    ),
    const _PlantPartItem(
      title: 'The Leaves',
      desc: 'Leaves grow on the stem and branches. They act as the plant\'s kitchen, catching sunlight to cook food for the plant!',
      imagePath: 'assets/plants/leaf.png',
      color: Colors.green,
      fallbackIcon: Icons.eco_rounded,
    ),
    const _PlantPartItem(
      title: 'The Flowers',
      desc: 'Flowers are the most colorful and beautiful part of a plant! They attract bees and help make seeds for new plants.',
      imagePath: 'assets/plants/flower.png',
      color: Colors.pink,
      fallbackIcon: Icons.filter_vintage_rounded,
    ),
    const _PlantPartItem(
      title: 'Fruits and Seeds',
      desc: 'Some flowers grow into delicious fruits! Inside the fruit are seeds, which fall to the soil and grow into new plants.',
      imagePath: 'assets/plants/fruits_seeds.png',
      color: Colors.red,
      fallbackIcon: Icons.apple_rounded,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _finishActivity() {
    final success = ref.read(userProvider.notifier).completeActivity('learn_Parts of a Plant', 20);
    if (success) {
      context.pushReplacement(AppRoutes.taskCompletion, extra: 20);
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9), // Soft green background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Parts of a Plant',
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
                          ? _pages[index].color
                          : Colors.grey.shade400,
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
                  final item = _pages[index];
                  
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: item.color.withValues(alpha: 0.2), width: 8),
                        boxShadow: [
                          BoxShadow(
                            color: item.color.withValues(alpha: 0.1),
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
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                color: item.color.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Image.asset(
                                  item.imagePath,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) => Icon(
                                    item.fallbackIcon,
                                    size: 110,
                                    color: item.color,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            Text(
                              item.title,
                              style: AppTextStyles.headlineLarge.copyWith(
                                fontSize: 36,
                                color: item.color,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              item.desc,
                              style: AppTextStyles.headlineMedium.copyWith(
                                fontSize: 22,
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
                    color: _currentPage > 0 ? AppColors.primary : Colors.grey.shade400,
                  ),
                  // Next
                  IconButton(
                    onPressed: _currentPage < _pages.length - 1 
                      ? () => _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut)
                      : null,
                    icon: const Icon(Icons.arrow_circle_right_rounded, size: 64),
                    color: _currentPage < _pages.length - 1 ? AppColors.primary : Colors.grey.shade400,
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
