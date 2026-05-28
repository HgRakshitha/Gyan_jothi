import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/providers/user_provider.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/widgets/app_asset_image.dart';

class AnimalNamesBookPage extends ConsumerStatefulWidget {
  const AnimalNamesBookPage({super.key});

  @override
  ConsumerState<AnimalNamesBookPage> createState() => _AnimalNamesBookPageState();
}

class _AnimalItem {
  final String imagePath;
  final String name;
  final Color color;
  final IconData fallback;

  const _AnimalItem(this.imagePath, this.name, this.color, this.fallback);
}

class _AnimalNamesBookPageState extends ConsumerState<AnimalNamesBookPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  
  final List<_AnimalItem> _pages = [
    const _AnimalItem('assets/animals/bear.png', 'Bear', Colors.brown, Icons.pets_rounded),
    const _AnimalItem('assets/animals/camel.png', 'Camel', Colors.orangeAccent, Icons.pets_rounded),
    const _AnimalItem('assets/animals/deer.png', 'Deer', Colors.deepOrange, Icons.pets_rounded),
    const _AnimalItem('assets/animals/donkey.png', 'Donkey', Colors.grey, Icons.pets_rounded),
    const _AnimalItem('assets/animals/fox.png', 'Fox', Colors.deepOrangeAccent, Icons.pets_rounded),
    const _AnimalItem('assets/animals/giraffe.png', 'Giraffe', Colors.amber, Icons.pets_rounded),
    const _AnimalItem('assets/animals/hippo.png', 'Hippo', Colors.blueGrey, Icons.pets_rounded),
    const _AnimalItem('assets/animals/jaguar.png', 'Jaguar', Colors.orange, Icons.pets_rounded),
    const _AnimalItem('assets/animals/rhino.png', 'Rhino', Colors.grey, Icons.pets_rounded),
    const _AnimalItem('assets/animals/wolf.png', 'Wolf', Colors.blueGrey, Icons.pets_rounded),
    const _AnimalItem('assets/animals/zebra.png', 'Zebra', Colors.black87, Icons.pets_rounded),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _finishActivity() {
    final success = ref.read(userProvider.notifier).completeActivity('learn_Animal Names', 20);
    if (success) {
      context.pushReplacement(AppRoutes.taskCompletion, extra: 20);
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0), // Soft orange background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Animal Names',
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
                              width: 220,
                              height: 220,
                              decoration: BoxDecoration(
                                color: item.color.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: AppAssetImage(
                                  assetPath: item.imagePath,
                                  width: 160,
                                  height: 160,
                                  fit: BoxFit.contain,
                                  fallback: Icon(
                                    item.fallback,
                                    size: 100,
                                    color: item.color,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),
                            Text(
                              item.name,
                              style: AppTextStyles.headlineLarge.copyWith(
                                fontSize: 48,
                                color: item.color,
                                fontWeight: FontWeight.w900,
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
