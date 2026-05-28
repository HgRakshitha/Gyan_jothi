import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';
import 'dart:async';

import '../../../../core/router/app_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../shared/providers/user_provider.dart';

class ColorObjectsPage extends ConsumerStatefulWidget {
  const ColorObjectsPage({super.key});

  @override
  ConsumerState<ColorObjectsPage> createState() => _ColorObjectsPageState();
}

class _ConveyorItem {
  final String id;
  final Color color;
  final IconData icon;
  bool isCollected = false;
  bool isWrong = false;

  _ConveyorItem(this.id, this.color, this.icon);
}

class _ColorObjectsPageState extends ConsumerState<ColorObjectsPage> {
  final List<Map<String, dynamic>> _targetColors = [
    {'name': 'RED', 'color': Colors.red},
    {'name': 'BLUE', 'color': Colors.blue},
    {'name': 'GREEN', 'color': Colors.green},
    {'name': 'YELLOW', 'color': Colors.amber},
    {'name': 'PURPLE', 'color': Colors.purple},
    {'name': 'ORANGE', 'color': Colors.orange},
    {'name': 'PINK', 'color': Colors.pink},
    {'name': 'BROWN', 'color': Colors.brown},
    {'name': 'BLACK', 'color': Colors.black},
    {'name': 'WHITE', 'color': Colors.white},
    {'name': 'GREY', 'color': Colors.grey},
  ];

  final List<IconData> _uniqueIcons = [
    Icons.camera_alt_rounded,
    Icons.anchor_rounded,
    Icons.directions_bus_rounded,
    Icons.headphones_rounded,
    Icons.extension_rounded,
    Icons.sports_esports_rounded,
    Icons.watch_rounded,
    Icons.vpn_key_rounded,
    Icons.sports_basketball_rounded,
    Icons.local_florist_rounded,
    Icons.coffee_rounded,
    Icons.keyboard_rounded,
    Icons.ac_unit_rounded,
    Icons.shield_rounded,
    Icons.icecream_rounded,
    Icons.cake_rounded,
    Icons.sports_soccer_rounded,
    Icons.menu_book_rounded,
  ];

  int _currentIndex = 0;
  final List<_ConveyorItem> _beltItems = [];
  int _score = 0;
  final int _targetScore = 3;
  
  late ScrollController _scrollController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _loadLevel();
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadLevel() {
    _score = 0;
    _beltItems.clear();
    
    final targetColor = _targetColors[_currentIndex]['color'] as Color;
    final random = Random();
    
    // Generate an endless-feeling list of 200 items
    for (int i = 0; i < 200; i++) {
      // 40% chance it's the target color, 60% chance it's random
      Color itemColor;
      if (random.nextDouble() < 0.4) {
        itemColor = targetColor;
      } else {
        itemColor = _targetColors[random.nextInt(_targetColors.length)]['color'] as Color;
      }
      
      _beltItems.add(_ConveyorItem(
        'item_$i',
        itemColor,
        _uniqueIcons[random.nextInt(_uniqueIcons.length)],
      ));
    }

    setState(() {});
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startConveyorBelt();
    });
  }

  void _startConveyorBelt() {
    _timer?.cancel();
    // 60 FPS smooth scrolling using jumpTo
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (_scrollController.hasClients) {
        double newOffset = _scrollController.offset + 1.5;
        if (newOffset >= _scrollController.position.maxScrollExtent) {
           newOffset = 0; // Loop back if they somehow reach the end
           _scrollController.jumpTo(newOffset);
        } else {
           _scrollController.jumpTo(newOffset);
        }
      }
    });
  }

  void _nextLevel() {
    if (_currentIndex < _targetColors.length - 1) {
      _currentIndex++;
      _loadLevel();
    } else {
      _finishActivity();
    }
  }

  void _finishActivity() {
    _timer?.cancel();
    final success = ref.read(userProvider.notifier).completeActivity('learn_Color & Objects', 20);
    if (success) {
      context.pushReplacement(AppRoutes.taskCompletion, extra: 20);
    } else {
      context.pop();
    }
  }
  
  void _onItemTapped(int index) {
    final item = _beltItems[index];
    if (item.isCollected || item.isWrong) return;
    
    final targetColor = _targetColors[_currentIndex]['color'] as Color;
    
    if (item.color == targetColor) {
      // Correct!
      setState(() {
        item.isCollected = true;
        _score++;
      });
      
      if (_score >= _targetScore) {
        _timer?.cancel();
        Future.delayed(const Duration(milliseconds: 1500), _nextLevel);
      }
    } else {
      // Wrong!
      setState(() {
        item.isWrong = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Oops! That's not ${_targetColors[_currentIndex]['name']}!"),
          backgroundColor: Colors.red.shade400,
          duration: const Duration(milliseconds: 800),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final target = _targetColors[_currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Factory Conveyor',
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
            
            // Collection Tube / Bin
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              decoration: BoxDecoration(
                color: target['color'] as Color,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: (target['color'] as Color).withValues(alpha: 0.4), blurRadius: 15, offset: const Offset(0, 5))
                ],
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: Column(
                children: [
                  Text(
                    'COLLECT',
                    style: AppTextStyles.titleMedium.copyWith(color: Colors.white70),
                  ),
                  Text(
                    target['name'] as String,
                    style: AppTextStyles.headlineLarge.copyWith(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(_targetScore, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Icon(
                          Icons.check_circle_rounded,
                          size: 30,
                          color: index < _score ? Colors.white : Colors.white.withValues(alpha: 0.3),
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
            
            const Spacer(),
            
            // Level Complete Banner
            if (_score >= _targetScore)
              AnimatedScale(
                scale: 1.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.elasticOut,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star_rounded, color: Colors.amber, size: 40),
                      const SizedBox(width: 10),
                      Text('Great Job!', style: AppTextStyles.headlineMedium.copyWith(color: Colors.green)),
                      const SizedBox(width: 10),
                      const Icon(Icons.star_rounded, color: Colors.amber, size: 40),
                    ],
                  ),
                ),
              ),
              
            const Spacer(),
            
            // Conveyor Belt Area
            SizedBox(
              height: 180,
              child: Stack(
                children: [
                  // The Belt track
                  Positioned.fill(
                    bottom: 20,
                    top: 130,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        border: const Border.symmetric(horizontal: BorderSide(color: Colors.black, width: 4)),
                      ),
                    ),
                  ),
                  
                  // The items rolling by
                  ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(), // User can't scroll manually
                    itemCount: _beltItems.length,
                    itemBuilder: (context, index) {
                      final item = _beltItems[index];
                      
                      return GestureDetector(
                        onTap: () => _onItemTapped(index),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: item.isCollected ? 0.0 : 1.0,
                            child: AnimatedScale(
                              duration: const Duration(milliseconds: 300),
                              scale: item.isCollected ? 0.0 : 1.0,
                              child: Container(
                                width: 90,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: item.isWrong ? Colors.grey.shade400 : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: item.color, width: 4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 10),
                                    )
                                  ]
                                ),
                                child: Center(
                                  child: Icon(
                                    item.icon,
                                    size: 45,
                                    color: item.isWrong ? Colors.grey.shade600 : item.color,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
