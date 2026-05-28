import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/providers/user_provider.dart';
import '../../../../core/router/app_router.dart';

class NumberChartPage extends ConsumerStatefulWidget {
  const NumberChartPage({super.key});

  @override
  ConsumerState<NumberChartPage> createState() => _NumberChartPageState();
}

class _NumberChartPageState extends ConsumerState<NumberChartPage> {
  final List<Map<String, dynamic>> _numbers = [
    {'num': 1, 'word': 'One', 'image': 'assets/numbers/one.png', 'color': Colors.red},
    {'num': 2, 'word': 'Two', 'image': 'assets/numbers/two.png', 'color': Colors.blue},
    {'num': 3, 'word': 'Three', 'image': 'assets/numbers/three.png', 'color': Colors.green},
    {'num': 4, 'word': 'Four', 'image': 'assets/numbers/four.png', 'color': Colors.amber},
    {'num': 5, 'word': 'Five', 'image': 'assets/numbers/five.png', 'color': Colors.purple},
    {'num': 6, 'word': 'Six', 'image': 'assets/numbers/six.png', 'color': Colors.orange},
    {'num': 7, 'word': 'Seven', 'image': 'assets/numbers/seven.png', 'color': Colors.pink},
    {'num': 8, 'word': 'Eight', 'image': 'assets/numbers/eight.png', 'color': Colors.brown},
    {'num': 9, 'word': 'Nine', 'image': 'assets/numbers/nine.png', 'color': Colors.teal},
    {'num': 10, 'word': 'Ten', 'image': 'assets/numbers/ten.png', 'color': Colors.indigo},
  ];

  void _finishActivity() {
    final success = ref.read(userProvider.notifier).completeActivity('learn_Number Chart', 20);
    if (success) {
      context.pushReplacement(AppRoutes.taskCompletion, extra: 20);
    } else {
      context.pop();
    }
  }

  void _showNumberPopup(Map<String, dynamic> data) {
    final color = data['color'] as Color;
    
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: color, width: 8),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                )
              ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Number
                Text(
                  '${data['num']}',
                  style: AppTextStyles.headlineLarge.copyWith(
                    fontSize: 80,
                    color: color,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                
                const SizedBox(height: 10),
                
                // Image
                SizedBox(
                  width: 260,
                  height: 260,
                  child: Center(
                    child: Image.asset(
                      data['image'] as String,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.image_not_supported_rounded,
                        size: 100,
                        color: color,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Word
                Text(
                  data['word'] as String,
                  style: AppTextStyles.headlineMedium.copyWith(
                    fontSize: 40,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 30),
                
                // Close button
                ElevatedButton(
                  onPressed: () => context.pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                  child: Text('Close', style: AppTextStyles.titleMedium.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Number Chart',
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 columns for big easy-to-tap squares
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: _numbers.length,
            itemBuilder: (context, index) {
              final item = _numbers[index];
              final color = item['color'] as Color;
              
              return GestureDetector(
                onTap: () => _showNumberPopup(item),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: color.withValues(alpha: 0.3), width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      )
                    ]
                  ),
                  child: Center(
                    child: Text(
                      '${item['num']}',
                      style: AppTextStyles.headlineLarge.copyWith(
                        fontSize: 60,
                        color: color,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
