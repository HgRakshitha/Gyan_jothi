import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../shared/providers/user_provider.dart';

class AlphabetChartPage extends ConsumerWidget {
  const AlphabetChartPage({super.key});

  void _finishActivity(BuildContext context, WidgetRef ref) {
    // Award coins and return
    final success = ref.read(userProvider.notifier).completeActivity('learn_Alphabet Chart', 15);
    if (success) {
      context.pushReplacement(AppRoutes.taskCompletion, extra: 15);
    } else {
      context.pop();
    }
  }

  void _showLetterDetails(BuildContext context, String letter) {
    // A placeholder word for each letter for demonstration
    final Map<String, String> wordMap = {
      'A': 'Apple', 'B': 'Ball', 'C': 'Cat', 'D': 'Dog', 'E': 'Elephant',
      'F': 'Fish', 'G': 'Grapes', 'H': 'Hat', 'I': 'Ice-cream', 'J': 'Jug',
      'K': 'Kite', 'L': 'Lion', 'M': 'Monkey', 'N': 'Nest', 'O': 'Owl',
      'P': 'Penguin', 'Q': 'Queen', 'R': 'Rabbit', 'S': 'Sun', 'T': 'Tiger',
      'U': 'Umbrella', 'V': 'Van', 'W': 'Watch', 'X': 'Xylophone', 'Y': 'Yak',
      'Z': 'Zebra',
    };

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: ScaleTransition(
              scale: CurvedAnimation(parent: animation, curve: Curves.elasticOut),
              child: Container(
                width: 300,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$letter${letter.toLowerCase()}',
                      style: const TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                        height: 1.0,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/alphabet_chart/${wordMap[letter]?.toLowerCase()}.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Center(
                            child: Icon(
                              Icons.image_not_supported_rounded,
                              size: 50,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      wordMap[letter] ?? '',
                      style: AppTextStyles.headlineMedium.copyWith(
                        fontSize: 28,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Awesome!',
                        style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String> letters = List.generate(26, (index) => String.fromCharCode(65 + index));

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Alphabet Chart',
          style: AppTextStyles.headlineMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        actions: [
          TextButton(
            onPressed: () => _finishActivity(context, ref),
            child: Text(
              'Done',
              style: AppTextStyles.titleMedium.copyWith(color: AppColors.primary),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Tap a letter to see the magic!',
                style: AppTextStyles.titleMedium,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: letters.length,
                  itemBuilder: (context, index) {
                    final letter = letters[index];
                    // Create a staggered color palette
                    final colors = [
                      Colors.redAccent,
                      Colors.blueAccent,
                      Colors.greenAccent.shade700,
                      Colors.orangeAccent,
                      Colors.purpleAccent,
                      Colors.tealAccent.shade700,
                    ];
                    final tileColor = colors[index % colors.length];

                    return GestureDetector(
                      onTap: () => _showLetterDetails(context, letter),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: tileColor.withValues(alpha: 0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: tileColor.withValues(alpha: 0.3),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            letter,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: tileColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
