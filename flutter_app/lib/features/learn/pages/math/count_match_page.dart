import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/providers/user_provider.dart';
import '../../../../core/router/app_router.dart';

class CountMatchPage extends ConsumerStatefulWidget {
  const CountMatchPage({super.key});

  @override
  ConsumerState<CountMatchPage> createState() => _CountMatchPageState();
}

class _MatchPair {
  final int number;
  final Color color;
  final IconData icon;
  bool isMatched = false;

  _MatchPair(this.number, this.color, this.icon);
}

class _CountMatchPageState extends ConsumerState<CountMatchPage> {
  final Random _random = Random();
  
  final List<_MatchPair> _pairs = [];
  List<_MatchPair> _leftColumn = [];
  List<_MatchPair> _rightColumn = [];
  
  final List<Color> _colors = [
    Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.pink
  ];
  
  final List<IconData> _icons = [
    Icons.star, Icons.favorite, Icons.pets, Icons.apple, 
    Icons.music_note, Icons.local_florist, Icons.cake
  ];

  @override
  void initState() {
    super.initState();
    _loadLevel();
  }

  void _loadLevel() {
    _pairs.clear();
    
    // Pick 3 random unique numbers between 1 and 6
    List<int> numbers = [];
    while (numbers.length < 3) {
      int num = _random.nextInt(6) + 1;
      if (!numbers.contains(num)) {
        numbers.add(num);
      }
    }
    
    // Create pairs
    for (int i = 0; i < 3; i++) {
      _pairs.add(_MatchPair(
        numbers[i],
        _colors[i],
        _icons[_random.nextInt(_icons.length)],
      ));
    }
    
    // Left column gets the numbers
    _leftColumn = List.from(_pairs);
    _leftColumn.shuffle(_random);
    
    // Right column gets the object groups
    _rightColumn = List.from(_pairs);
    _rightColumn.shuffle(_random);
    
    setState(() {});
  }

  void _checkWinCondition() {
    if (_pairs.every((p) => p.isMatched)) {
      Future.delayed(const Duration(milliseconds: 800), () {
        if (!mounted) return;
        _loadLevel();
      });
    }
  }

  void _finishActivity() {
    final success = ref.read(userProvider.notifier).completeActivity('learn_Count & Match', 15);
    if (success) {
      context.pushReplacement(AppRoutes.taskCompletion, extra: 15);
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0), // Soft orange bg
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Count & Match',
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            children: [
              Text(
                'Drag the number to the matching pictures!',
                style: AppTextStyles.titleMedium.copyWith(color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              
              Expanded(
                child: Row(
                  children: [
                    // Left Column: Numbers (Draggable)
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _leftColumn.map((pair) {
                          if (pair.isMatched) {
                            return const SizedBox(height: 100, width: 100);
                          }
                          
                          return Draggable<_MatchPair>(
                            data: pair,
                            feedback: Material(
                              color: Colors.transparent,
                              child: _buildNumberBlock(pair, 1.2),
                            ),
                            childWhenDragging: Opacity(
                              opacity: 0.3,
                              child: _buildNumberBlock(pair, 1.0),
                            ),
                            child: _buildNumberBlock(pair, 1.0),
                          );
                        }).toList(),
                      ),
                    ),
                    
                    const SizedBox(width: 20),
                    
                    // Right Column: Object Groups (DragTarget)
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _rightColumn.map((targetPair) {
                          return DragTarget<_MatchPair>(
                            onWillAcceptWithDetails: (details) => true,
                            onAcceptWithDetails: (details) {
                              if (details.data.number == targetPair.number) {
                                setState(() {
                                  details.data.isMatched = true;
                                  targetPair.isMatched = true;
                                });
                                _checkWinCondition();
                              }
                            },
                            builder: (context, candidateData, rejectedData) {
                              final isHovering = candidateData.isNotEmpty;
                              
                              if (targetPair.isMatched) {
                                return _buildMatchedState(targetPair);
                              }
                              
                              return _buildObjectGroup(targetPair, isHovering);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildNumberBlock(_MatchPair pair, double scale) {
    return Transform.scale(
      scale: scale,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: pair.color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: pair.color.withValues(alpha: 0.4),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ]
        ),
        child: Center(
          child: Text(
            '${pair.number}',
            style: AppTextStyles.headlineLarge.copyWith(
              fontSize: 60,
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildObjectGroup(_MatchPair pair, bool isHovering) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: isHovering ? pair.color.withValues(alpha: 0.2) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isHovering ? pair.color : Colors.grey.shade300,
          width: isHovering ? 4 : 2,
        ),
      ),
      child: Center(
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: List.generate(
            pair.number,
            (index) => Icon(
              pair.icon,
              size: 40,
              color: pair.color,
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildMatchedState(_MatchPair pair) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: pair.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: pair.color, width: 4),
      ),
      child: Stack(
        children: [
          Center(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: List.generate(
                pair.number,
                (index) => Icon(
                  pair.icon,
                  size: 40,
                  color: pair.color.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: pair.color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: pair.color.withValues(alpha: 0.5), blurRadius: 10, offset: const Offset(0, 4))
                ]
              ),
              child: const Icon(Icons.check_rounded, color: Colors.white, size: 50),
            ),
          ),
        ],
      ),
    );
  }
}
