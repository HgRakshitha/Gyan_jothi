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

class LivingOrNotActivityPage extends ConsumerStatefulWidget {
  const LivingOrNotActivityPage({super.key});

  @override
  ConsumerState<LivingOrNotActivityPage> createState() => _LivingOrNotActivityPageState();
}

class _SortItem {
  final String imagePath;
  final String name;
  final bool isLiving;
  final Color color;

  _SortItem(this.imagePath, this.name, this.isLiving, this.color);
}

class _LivingOrNotActivityPageState extends ConsumerState<LivingOrNotActivityPage> with SingleTickerProviderStateMixin {
  final Random _random = Random();
  int _score = 0;
  final int _maxScore = 9;
  
  late _SortItem _currentItem;
  late AnimationController _shakeController;
  
  final List<_SortItem> _pool = [
    // Living
    _SortItem('assets/activity_livOrNot/human.webp', 'Human', true, Colors.orange),
    _SortItem('assets/activity_livOrNot/plant.webp', 'Plant', true, Colors.green),
    _SortItem('assets/activity_livOrNot/rabbit.webp', 'Rabbit', true, Colors.grey),
    _SortItem('assets/activity_livOrNot/rat.webp', 'Rat', true, Colors.brown),
    // Non-Living
    _SortItem('assets/activity_livOrNot/car.webp', 'Car', false, Colors.blue),
    _SortItem('assets/activity_livOrNot/cloth.webp', 'Cloth', false, Colors.purple),
    _SortItem('assets/activity_livOrNot/pen.webp', 'Pen', false, Colors.redAccent),
    _SortItem('assets/activity_livOrNot/robot.webp', 'Robot', false, Colors.teal),
    _SortItem('assets/activity_livOrNot/watch.webp', 'Watch', false, Colors.black87),
  ];

  late List<_SortItem> _questions;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _questions = List.from(_pool)..shuffle(_random);
    _loadLevel();
  }
  
  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _loadLevel() {
    if (_currentIndex < _questions.length) {
      _currentItem = _questions[_currentIndex];
    }
    setState(() {});
  }

  void _finishActivity() {
    final success = ref.read(userProvider.notifier).completeActivity('learn_Living or Not?', 15);
    if (success) {
      context.pushReplacement(AppRoutes.taskCompletion, extra: 15);
    } else {
      context.pop();
    }
  }
  
  void _onDropped(bool droppedOnLiving) {
    if (droppedOnLiving == _currentItem.isLiving) {
      // Correct!
      HapticFeedback.mediumImpact();
      _score++;
      _currentIndex++;
      if (_score >= _maxScore || _currentIndex >= _questions.length) {
        _finishActivity();
      } else {
        _loadLevel();
      }
    } else {
      // Wrong!
      HapticFeedback.heavyImpact();
      _shakeController.forward(from: 0);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            droppedOnLiving ? "Oops! That is NOT living." : "Oops! That IS a living thing.",
          ),
          backgroundColor: Colors.red.shade400,
          duration: const Duration(milliseconds: 1000),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBE7), // Very soft lime green
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Living or Not?',
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
              'Drag to the correct box!',
              style: AppTextStyles.headlineMedium.copyWith(color: Colors.black54),
            ),
            
            const Spacer(),
            
            // The Item to drag
            AnimatedBuilder(
              animation: _shakeController,
              builder: (context, child) {
                // Shake effect if wrong
                final val = sin(_shakeController.value * pi * 4);
                return Transform.translate(
                  offset: Offset(val * 10, 0),
                  child: child,
                );
              },
              child: Draggable<_SortItem>(
                data: _currentItem,
                feedback: Material(
                  color: Colors.transparent,
                  child: _buildDraggableCard(_currentItem, 1.1),
                ),
                childWhenDragging: Opacity(
                  opacity: 0.2,
                  child: _buildDraggableCard(_currentItem, 1.0),
                ),
                child: _buildDraggableCard(_currentItem, 1.0),
              ),
            ),
            
            const Spacer(),
            
            // The Drop Targets
            Padding(
              padding: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Living Target
                  Expanded(
                    child: DragTarget<_SortItem>(
                      onWillAcceptWithDetails: (d) => true,
                      onAcceptWithDetails: (d) => _onDropped(true),
                      builder: (context, candidateData, rejectedData) {
                        return _buildDropZone(
                          'Living',
                          Icons.eco_rounded,
                          Colors.green,
                          candidateData.isNotEmpty,
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  // Non-Living Target
                  Expanded(
                    child: DragTarget<_SortItem>(
                      onWillAcceptWithDetails: (d) => true,
                      onAcceptWithDetails: (d) => _onDropped(false),
                      builder: (context, candidateData, rejectedData) {
                        return _buildDropZone(
                          'Non-Living',
                          Icons.toys_rounded,
                          Colors.grey.shade600,
                          candidateData.isNotEmpty,
                        );
                      },
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
  
  Widget _buildDraggableCard(_SortItem item, double scale) {
    return Transform.scale(
      scale: scale,
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: item.color.withValues(alpha: 0.3), width: 8),
          boxShadow: [
            BoxShadow(
              color: item.color.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppAssetImage(
  assetPath: item.imagePath,
  width: 80,
  height: 80,
  fit: BoxFit.contain,
  fallback: const SizedBox.shrink(),
),
            const SizedBox(height: 10),
            Text(
              item.name,
              style: AppTextStyles.headlineMedium.copyWith(
                color: item.color,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
  
  Widget _buildDropZone(String title, IconData icon, Color color, bool isHovering) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 150,
      decoration: BoxDecoration(
        color: isHovering ? color.withValues(alpha: 0.2) : color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isHovering ? color : color.withValues(alpha: 0.5),
          width: isHovering ? 6 : 3,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 50, color: color),
          const SizedBox(height: 10),
          Text(
            title,
            style: AppTextStyles.titleMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
