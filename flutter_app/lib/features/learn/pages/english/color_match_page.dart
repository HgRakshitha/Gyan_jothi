import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';

import '../../../../core/router/app_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../shared/providers/user_provider.dart';
import '../../../../shared/widgets/custom_button.dart';

class ColorMatchPage extends ConsumerStatefulWidget {
  const ColorMatchPage({super.key});

  @override
  ConsumerState<ColorMatchPage> createState() => _ColorMatchPageState();
}

class _BalloonItem {
  final String id;
  final Color color;
  final IconData icon;

  _BalloonItem(this.id, this.color, this.icon);
}

class _ColorMatchPageState extends ConsumerState<ColorMatchPage> {
  final List<Color> _allColors = [
    Colors.red, Colors.blue, Colors.green, Colors.amber, 
    Colors.purple, Colors.orange, Colors.pink, Colors.brown, 
    Colors.black, Colors.white, Colors.grey
  ];
  
  List<Color> _trainColors = [];
  final List<_BalloonItem> _balloons = [];
  Map<Color, int> _trainCounts = {};
  
  final int _totalBalloons = 12;
  bool _trainDeparting = false;

  @override
  void initState() {
    super.initState();
    _startRound();
  }

  void _startRound() {
    _trainDeparting = false;
    
    // Pick 4 random colors for the train
    final random = Random();
    _trainColors = _allColors.toList()..shuffle(random);
    _trainColors = _trainColors.take(4).toList();
    
    _trainCounts = {for (var color in _trainColors) color: 0};
    _balloons.clear();
    
    // Unique balloon shapes
    final icons = [
      Icons.star_rounded, Icons.favorite_rounded, Icons.water_drop_rounded, 
      Icons.hexagon_rounded, Icons.square_rounded, Icons.circle, 
      Icons.change_history_rounded, Icons.cloud_rounded
    ];
    
    for (int i = 0; i < _totalBalloons; i++) {
      _balloons.add(_BalloonItem(
        'balloon_$i',
        _trainColors[random.nextInt(_trainColors.length)],
        icons[random.nextInt(icons.length)],
      ));
    }
  }

  void _finishActivity() {
    final success = ref.read(userProvider.notifier).completeActivity('learn_Color Match', 30);
    if (success) {
      context.pushReplacement(AppRoutes.taskCompletion, extra: 30);
    } else {
      context.pop();
    }
  }

  void _checkCompletion() {
    if (_balloons.isEmpty) {
      setState(() {
        _trainDeparting = true;
      });
    }
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
          'The Color Train',
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
            const SizedBox(height: 20),
            Text(
              'Load the colored balloons into the train cars!',
              style: AppTextStyles.titleMedium,
            ),
            
            // Balloons Floating Area
            Expanded(
              child: _trainDeparting 
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.celebration_rounded, color: Colors.amber, size: 100),
                        const SizedBox(height: 20),
                        Text('Choo Choo! Great Job!', style: AppTextStyles.headlineMedium),
                        const SizedBox(height: 30),
                        CustomButton(
                          label: 'Finish',
                          onTap: _finishActivity,
                        )
                      ],
                    ),
                  )
                : Stack(
                    children: _balloons.asMap().entries.map((entry) {
                      int index = entry.key;
                      var balloon = entry.value;
                      // Staggered layout
                      double leftPos = 30.0 + (index % 4) * 80;
                      double topPos = 20.0 + (index ~/ 4) * 80;
                      
                      return Positioned(
                        left: leftPos,
                        top: topPos,
                        child: Draggable<_BalloonItem>(
                          data: balloon,
                          feedback: _buildBalloon(balloon, isDragging: true),
                          childWhenDragging: Opacity(
                            opacity: 0.0,
                            child: _buildBalloon(balloon),
                          ),
                          child: _buildBalloon(balloon),
                        ),
                      );
                    }).toList(),
                  ),
            ),
            
            // The Train
            AnimatedSlide(
              offset: _trainDeparting ? const Offset(1.5, 0) : Offset.zero,
              duration: const Duration(seconds: 2),
              curve: Curves.easeIn,
              child: Container(
                height: 140,
                padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Colors.brown.shade800,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Engine
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Icon(Icons.train_rounded, color: Colors.grey, size: 60),
                    ),
                    // Train Cars
                    ..._trainColors.map((color) {
                      return DragTarget<_BalloonItem>(
                        onWillAcceptWithDetails: (details) => details.data.color == color,
                        onAcceptWithDetails: (details) {
                          setState(() {
                            _balloons.removeWhere((b) => b.id == details.data.id);
                            _trainCounts[color] = (_trainCounts[color] ?? 0) + 1;
                          });
                          _checkCompletion();
                        },
                        builder: (context, candidateData, rejectedData) {
                          bool isHovered = candidateData.isNotEmpty;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 60,
                            height: isHovered ? 90 : 80,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.8),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                if (isHovered)
                                  BoxShadow(
                                    color: color,
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  )
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '${_trainCounts[color]}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalloon(_BalloonItem item, {bool isDragging = false}) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: item.color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDragging ? 0.3 : 0.1),
                  blurRadius: isDragging ? 10 : 4,
                  offset: Offset(0, isDragging ? 8 : 4),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                item.icon,
                size: 32,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ),
          // Balloon String
          Container(
            width: 2,
            height: 20,
            color: Colors.grey.shade400,
          )
        ],
      ),
    );
  }
}
