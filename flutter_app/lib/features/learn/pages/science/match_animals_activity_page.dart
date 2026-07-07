import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/providers/user_provider.dart';
import '../../../../core/router/app_router.dart';
import '../../../../shared/widgets/app_asset_image.dart';

class MatchAnimalsActivityPage extends ConsumerStatefulWidget {
  const MatchAnimalsActivityPage({super.key});

  @override
  ConsumerState<MatchAnimalsActivityPage> createState() => _MatchAnimalsActivityPageState();
}

class _AnimalPair {
  final String imagePath;
  final String name;
  final Color color;
  final IconData fallback;
  bool isMatched = false;

  _AnimalPair(this.imagePath, this.name, this.color, this.fallback);
}

class _MatchAnimalsActivityPageState extends ConsumerState<MatchAnimalsActivityPage> {
  final Random _random = Random();
  int _score = 0;
  final int _maxScore = 5;

  late List<_AnimalPair> _currentPairs;
  late List<_AnimalPair> _shuffledImages;
  late List<_AnimalPair> _shuffledNames;

  final List<_AnimalPair> _allAnimals = [
    _AnimalPair('assets/animals/bear.webp', 'Bear', Colors.brown, Icons.pets_rounded),
    _AnimalPair('assets/animals/camel.webp', 'Camel', Colors.orangeAccent, Icons.pets_rounded),
    _AnimalPair('assets/animals/deer.webp', 'Deer', Colors.deepOrange, Icons.pets_rounded),
    _AnimalPair('assets/animals/donkey.webp', 'Donkey', Colors.grey, Icons.pets_rounded),
    _AnimalPair('assets/animals/fox.webp', 'Fox', Colors.deepOrangeAccent, Icons.pets_rounded),
    _AnimalPair('assets/animals/giraffe.webp', 'Giraffe', Colors.amber, Icons.pets_rounded),
    _AnimalPair('assets/animals/hippo.webp', 'Hippo', Colors.blueGrey, Icons.pets_rounded),
    _AnimalPair('assets/animals/jaguar.webp', 'Jaguar', Colors.orange, Icons.pets_rounded),
    _AnimalPair('assets/animals/rhino.webp', 'Rhino', Colors.grey, Icons.pets_rounded),
    _AnimalPair('assets/animals/wolf.webp', 'Wolf', Colors.blueGrey, Icons.pets_rounded),
    _AnimalPair('assets/animals/zebra.webp', 'Zebra', Colors.black87, Icons.pets_rounded),
  ];

  @override
  void initState() {
    super.initState();
    _loadLevel();
  }

  void _loadLevel() {
    // Pick 3 random animals
    final pool = List<_AnimalPair>.from(_allAnimals)..shuffle(_random);
    _currentPairs = pool.take(3).map((p) => _AnimalPair(p.imagePath, p.name, p.color, p.fallback)).toList();

    _shuffledImages = List.from(_currentPairs)..shuffle(_random);
    _shuffledNames = List.from(_currentPairs)..shuffle(_random);

    setState(() {});
  }

  void _finishActivity() {
    final success = ref.read(userProvider.notifier).completeActivity('learn_Match the Animals', 30);
    if (success) {
      context.pushReplacement(AppRoutes.taskCompletion, extra: 30);
    } else {
      context.pop();
    }
  }

  void _onMatched() {
    HapticFeedback.mediumImpact();
    setState(() {});
    
    if (_currentPairs.every((p) => p.isMatched)) {
      _score++;
      if (_score >= _maxScore) {
        Future.delayed(const Duration(milliseconds: 600), _finishActivity);
      } else {
        Future.delayed(const Duration(milliseconds: 1000), _loadLevel);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBE7), // Soft lime-yellow background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Match the Animals',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            children: [
              Text(
                'Drag the animal to its name!',
                style: AppTextStyles.headlineMedium.copyWith(color: Colors.black54),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Draggable Images
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _shuffledImages.map((pair) {
                          if (pair.isMatched) {
                            return _buildEmptyBox();
                          }
                          return Draggable<_AnimalPair>(
                            data: pair,
                            feedback: Material(
                              color: Colors.transparent,
                              child: _buildDraggableCard(pair, 1.1),
                            ),
                            childWhenDragging: Opacity(
                              opacity: 0.2,
                              child: _buildDraggableCard(pair, 1.0),
                            ),
                            child: _buildDraggableCard(pair, 1.0),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Drop Targets (Names)
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _shuffledNames.map((pair) {
                          return DragTarget<_AnimalPair>(
                            onWillAcceptWithDetails: (d) => true,
                            onAcceptWithDetails: (d) {
                              if (d.data.name == pair.name) {
                                pair.isMatched = true;
                                d.data.isMatched = true;
                                _onMatched();
                              } else {
                                HapticFeedback.heavyImpact();
                              }
                            },
                            builder: (context, candidateData, rejectedData) {
                              return _buildTargetZone(pair, candidateData.isNotEmpty);
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

  Widget _buildEmptyBox() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.3),
          width: 3,
          style: BorderStyle.solid,
        ),
      ),
    );
  }

  Widget _buildDraggableCard(_AnimalPair pair, double scale) {
    return Transform.scale(
      scale: scale,
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: pair.color.withValues(alpha: 0.3), width: 6),
          boxShadow: [
            BoxShadow(
              color: pair.color.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ]
        ),
        child: ClipOval(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: AppAssetImage(
              assetPath: pair.imagePath,
              width: 90,
              height: 90,
              fit: BoxFit.contain,
              fallback: Icon(
                pair.fallback,
                size: 60,
                color: pair.color,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTargetZone(_AnimalPair pair, bool isHovering) {
    if (pair.isMatched) {
      return Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          color: pair.color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: pair.color, width: 4),
        ),
        child: Center(
          child: Text(
            pair.name,
            style: AppTextStyles.titleMedium.copyWith(
              fontSize: 22,
              color: pair.color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 150,
      height: 100,
      decoration: BoxDecoration(
        color: isHovering ? Colors.black.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isHovering ? Colors.black45 : Colors.black12,
          width: isHovering ? 4 : 2,
        ),
      ),
      child: Center(
        child: Text(
          pair.name,
          style: AppTextStyles.titleMedium.copyWith(
            fontSize: 22,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
