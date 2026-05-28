import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/providers/user_provider.dart';
import '../../../../core/router/app_router.dart';

class TapNumberPage extends ConsumerStatefulWidget {
  const TapNumberPage({super.key});

  @override
  ConsumerState<TapNumberPage> createState() => _TapNumberPageState();
}

class _NumberOption {
  final int number;
  final Color color;
  bool isWrong = false;

  _NumberOption(this.number, this.color);
}

class _TapNumberPageState extends ConsumerState<TapNumberPage> with SingleTickerProviderStateMixin {
  int _targetNumber = 1;
  int _score = 0;
  final int _maxScore = 5;
  
  final List<_NumberOption> _options = [];
  
  final List<Color> _balloonColors = [
    Colors.red, Colors.blue, Colors.green, Colors.amber,
    Colors.purple, Colors.orange, Colors.pink, Colors.teal
  ];
  
  late AnimationController _bobController;

  @override
  void initState() {
    super.initState();
    _bobController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    
    _loadLevel();
  }
  
  @override
  void dispose() {
    _bobController.dispose();
    super.dispose();
  }

  void _loadLevel() {
    final random = Random();
    _targetNumber = random.nextInt(10) + 1; // 1 to 10
    
    _options.clear();
    
    // 1 correct option
    _options.add(_NumberOption(
      _targetNumber,
      _balloonColors[random.nextInt(_balloonColors.length)],
    ));
    
    // 5 wrong options
    while (_options.length < 6) {
      int wrongNum = random.nextInt(10) + 1;
      if (wrongNum != _targetNumber) {
        // Make sure we don't have too many duplicates, but some are fine.
        _options.add(_NumberOption(
          wrongNum,
          _balloonColors[random.nextInt(_balloonColors.length)],
        ));
      }
    }
    
    _options.shuffle(random);
    setState(() {});
  }

  void _finishActivity() {
    final success = ref.read(userProvider.notifier).completeActivity('learn_Tap the Number', 15);
    if (success) {
      context.pushReplacement(AppRoutes.taskCompletion, extra: 15);
    } else {
      context.pop();
    }
  }

  void _onTap(_NumberOption option) {
    if (option.isWrong) return;
    
    if (option.number == _targetNumber) {
      // Correct!
      _score++;
      if (_score >= _maxScore) {
        _finishActivity();
      } else {
        _loadLevel();
      }
    } else {
      // Wrong
      setState(() {
        option.isWrong = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Oops! That's ${option.number}, not $_targetNumber!"),
          backgroundColor: Colors.red.shade400,
          duration: const Duration(milliseconds: 800),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD), // Light blue sky background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Tap the Number',
          style: AppTextStyles.headlineMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '$_score / $_maxScore',
                style: AppTextStyles.titleMedium.copyWith(color: AppColors.primary),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Instruction
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))
                ]
              ),
              child: Column(
                children: [
                  Text(
                    'Find the number',
                    style: AppTextStyles.titleMedium.copyWith(color: Colors.black54),
                  ),
                  Text(
                    '$_targetNumber',
                    style: AppTextStyles.headlineLarge.copyWith(
                      fontSize: 60,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            
            const Spacer(),
            
            // Balloons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Wrap(
                spacing: 20,
                runSpacing: 40,
                alignment: WrapAlignment.center,
                children: _options.map((option) {
                  // Create a slight random offset for the bobbing animation to make them out of sync
                  final offsetDelay = _options.indexOf(option) * 0.2;
                  
                  return GestureDetector(
                    onTap: () => _onTap(option),
                    child: AnimatedBuilder(
                      animation: _bobController,
                      builder: (context, child) {
                        // Calculate a smooth sine wave offset
                        final val = sin((_bobController.value * 2 * pi) + offsetDelay);
                        return Transform.translate(
                          offset: Offset(0, val * 10), // Bob up and down 10 pixels
                          child: child,
                        );
                      },
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: option.isWrong ? 0.3 : 1.0,
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 300),
                          scale: option.isWrong ? 0.8 : 1.0,
                          child: Container(
                            width: 100,
                            height: 120, // Taller like a balloon
                            decoration: BoxDecoration(
                              color: option.color,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(50),
                                bottom: Radius.circular(40),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: option.color.withValues(alpha: 0.4),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                )
                              ],
                              border: Border.all(color: Colors.white, width: 3),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Highlight to make it look 3D and shiny
                                Positioned(
                                  top: 10,
                                  left: 20,
                                  child: Container(
                                    width: 20,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.3),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                // Number Text
                                Text(
                                  '${option.number}',
                                  style: AppTextStyles.headlineLarge.copyWith(
                                    fontSize: 50,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
