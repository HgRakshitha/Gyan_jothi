import 'package:gyan_jyoti/shared/widgets/app_asset_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/providers/user_provider.dart';
import '../../../../core/router/app_router.dart';
import 'package:flutter/services.dart';

class CountObjectsPage extends ConsumerStatefulWidget {
  const CountObjectsPage({super.key});

  @override
  ConsumerState<CountObjectsPage> createState() => _CountObjectsPageState();
}

class _CountObjectsPageState extends ConsumerState<CountObjectsPage> with SingleTickerProviderStateMixin {
  final Random _random = Random();
  int _targetNumber = 1;
  int _score = 0;
  final int _maxScore = 5;
  
  Color _currentColor = Colors.blue;
  String _currentImage = 'assets/welcome/welcome_bunny.webp';
  
  List<int> _options = [];
  int? _wrongChoice;
  
  late AnimationController _shakeController;
  
  final List<Color> _colors = [
    Colors.red, Colors.blue, Colors.green, Colors.amber, 
    Colors.purple, Colors.orange, Colors.pink, Colors.teal
  ];
  
  final List<String> _images = [
    'assets/welcome/welcome_bunny.webp',
    'assets/welcome/welcome_cat.webp',
    'assets/welcome/welcome_fox.webp',
    'assets/welcome/welcome_monkey.webp',
    'assets/welcome/welcome_panda.webp',
    'assets/welcome/all_done_bear.webp',
    'assets/welcome/all_done_bunny.webp',
    'assets/welcome/all_done_cat.webp',
    'assets/welcome/all_done_fox.webp',
    'assets/welcome/all_done_owl.webp',
  ];

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _loadLevel();
  }
  
  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _loadLevel() {
    _targetNumber = _random.nextInt(10) + 1; // 1 to 10
    _currentColor = _colors[_random.nextInt(_colors.length)];
    _currentImage = _images[_random.nextInt(_images.length)];
    _wrongChoice = null;
    
    _options = [_targetNumber];
    while (_options.length < 3) {
      int wrongNum = _random.nextInt(10) + 1;
      if (!_options.contains(wrongNum)) {
        _options.add(wrongNum);
      }
    }
    
    _options.shuffle(_random);
    setState(() {});
  }

  void _finishActivity() {
    final success = ref.read(userProvider.notifier).completeActivity('learn_Count the Objects', 30);
    if (success) {
      context.pushReplacement(AppRoutes.taskCompletion, extra: 30);
    } else {
      context.pop();
    }
  }
  
  void _onOptionSelected(int choice) {
    if (choice == _targetNumber) {
      // Correct!
      _score++;
      if (_score >= _maxScore) {
        _finishActivity();
      } else {
        _loadLevel();
      }
    } else {
      // Wrong!
      HapticFeedback.heavyImpact();
      setState(() {
        _wrongChoice = choice;
      });
      _shakeController.forward(from: 0);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Try again! Count carefully."),
          backgroundColor: Colors.red.shade400,
          duration: const Duration(milliseconds: 800),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E5F5), // Soft purple background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Count the Objects',
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
            
            Text(
              'How many do you see?',
              style: AppTextStyles.headlineMedium.copyWith(color: Colors.black87),
            ),
            
            const Spacer(),
            
            // The Objects
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: AnimatedBuilder(
                animation: _shakeController,
                builder: (context, child) {
                  // Shake effect if wrong
                  final val = sin(_shakeController.value * pi * 4);
                  return Transform.translate(
                    offset: Offset(val * 10, 0),
                    child: child,
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: _currentColor.withValues(alpha: 0.15),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      )
                    ],
                    border: Border.all(
                      color: _currentColor.withValues(alpha: 0.3),
                      width: 8,
                    ),
                  ),
                  child: Center(
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: List.generate(
                        _targetNumber,
                        (index) => AppAssetImage(
  assetPath: _currentImage,
  width: _targetNumber > 6 ? 50 : 70,
  height: _targetNumber > 6 ? 50 : 70,
  fit: BoxFit.contain,
  fallback: const SizedBox.shrink(),
),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            const Spacer(),
            
            // Multiple Choice Options
            Padding(
              padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _options.map((option) {
                  final isWrong = _wrongChoice == option;
                  return GestureDetector(
                    onTap: () => _onOptionSelected(option),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: isWrong ? Colors.grey.shade300 : Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: isWrong ? [] : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          )
                        ],
                        border: Border.all(
                          color: isWrong ? Colors.grey : _currentColor,
                          width: isWrong ? 2 : 4,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$option',
                          style: AppTextStyles.headlineLarge.copyWith(
                            fontSize: 48,
                            color: isWrong ? Colors.grey : _currentColor,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
