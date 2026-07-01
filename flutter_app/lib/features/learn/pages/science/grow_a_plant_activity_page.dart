import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

import '../../../../core/theme/text_styles.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/providers/user_provider.dart';
import '../../../../core/router/app_router.dart';

class GrowAPlantActivityPage extends ConsumerStatefulWidget {
  const GrowAPlantActivityPage({super.key});

  @override
  ConsumerState<GrowAPlantActivityPage> createState() => _GrowAPlantActivityPageState();
}

enum PlantTool { soil, seed, water, sun }

class _ToolItem {
  final PlantTool tool;
  final String name;
  final String emoji;
  final Color color;
  final IconData icon;

  const _ToolItem({
    required this.tool,
    required this.name,
    required this.emoji,
    required this.color,
    required this.icon,
  });
}

class _GrowAPlantActivityPageState extends ConsumerState<GrowAPlantActivityPage> with TickerProviderStateMixin {
  int _currentStep = 0; // 0: Soil, 1: Seed, 2: Water, 3: Sun, 4: Done
  final int _maxSteps = 4;
  late AnimationController _shakeController;
  late AnimationController _pulseController;

  final List<_ToolItem> _tools = [
    const _ToolItem(
      tool: PlantTool.soil,
      name: 'Soil',
      emoji: '🟫',
      color: Colors.brown,
      icon: Icons.layers_rounded,
    ),
    const _ToolItem(
      tool: PlantTool.seed,
      name: 'Seed',
      emoji: '🌰',
      color: Colors.orange,
      icon: Icons.grain_rounded,
    ),
    const _ToolItem(
      tool: PlantTool.water,
      name: 'Water',
      emoji: '💧',
      color: Colors.blue,
      icon: Icons.opacity_rounded,
    ),
    const _ToolItem(
      tool: PlantTool.sun,
      name: 'Sunlight',
      emoji: '☀️',
      color: Colors.amber,
      icon: Icons.wb_sunny_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _finishActivity() {
    final success = ref.read(userProvider.notifier).completeActivity('learn_Grow a Plant', 15);
    if (success) {
      context.pushReplacement(AppRoutes.taskCompletion, extra: 15);
    } else {
      context.pop();
    }
  }

  void _applyTool(PlantTool tool) {
    if (_currentStep >= _maxSteps) return;

    final expectedTool = _getExpectedToolForStep(_currentStep);
    if (tool == expectedTool) {
      // Correct!
      HapticFeedback.mediumImpact();
      setState(() {
        _currentStep++;
      });

      if (_currentStep == _maxSteps) {
        // Complete the activity after a short delay so they can see the full bloom!
        Future.delayed(const Duration(milliseconds: 2000), () {
          if (mounted) {
            _finishActivity();
          }
        });
      }
    } else {
      // Incorrect!
      HapticFeedback.heavyImpact();
      _shakeController.forward(from: 0);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Oops! Try using ${_getToolNameForExpectedStep()} first!',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red.shade400,
          duration: const Duration(milliseconds: 1200),
        ),
      );
    }
  }

  PlantTool _getExpectedToolForStep(int step) {
    switch (step) {
      case 0:
        return PlantTool.soil;
      case 1:
        return PlantTool.seed;
      case 2:
        return PlantTool.water;
      case 3:
      default:
        return PlantTool.sun;
    }
  }

  String _getToolNameForExpectedStep() {
    switch (_currentStep) {
      case 0:
        return 'Soil';
      case 1:
        return 'Seed';
      case 2:
        return 'Water';
      case 3:
      default:
        return 'Sunlight';
    }
  }

  String _getInstructionText() {
    switch (_currentStep) {
      case 0:
        return 'Drag or Tap the Soil to fill the pot!';
      case 1:
        return 'Awesome! Now sow the Seed in the soil.';
      case 2:
        return 'Water the seed to help it sprout!';
      case 3:
        return 'Give it some warm Sunlight to grow!';
      case 4:
      default:
        return 'Wow! Your plant has fully bloomed! 🌸';
    }
  }

  Widget _buildPotIllustration() {
    // Determine visuals based on current growth step
    Widget potContents;
    String topEmoji = '';

    if (_currentStep == 0) {
      // Empty pot
      potContents = Center(
        child: Icon(
          Icons.eco_outlined,
          size: 64,
          color: Colors.grey.withValues(alpha: 0.3),
        ),
      );
    } else if (_currentStep == 1) {
      // Soil added
      potContents = Container(
        margin: const EdgeInsets.only(top: 60),
        decoration: const BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: const Center(
          child: Text(
            'Rich Soil',
            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
          ),
        ),
      );
      topEmoji = '🟫';
    } else if (_currentStep == 2) {
      // Seed planted
      potContents = Container(
        margin: const EdgeInsets.only(top: 60),
        decoration: const BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: const Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 10,
              child: Text('🌰', style: TextStyle(fontSize: 24)),
            ),
          ],
        ),
      );
      topEmoji = '🌰';
    } else if (_currentStep == 3) {
      // Sprouted
      potContents = Container(
        margin: const EdgeInsets.only(top: 60),
        decoration: const BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -36,
              child: Image.asset(
                'assets/plants/leaf.png',
                width: 56,
                height: 56,
                fit: BoxFit.contain,
                errorBuilder: (c, e, s) => const Text('🌱', style: TextStyle(fontSize: 48)),
              ),
            ),
          ],
        ),
      );
      topEmoji = '💧';
    } else {
      // Fully bloomed!
      potContents = Container(
        margin: const EdgeInsets.only(top: 60),
        decoration: const BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -65,
              child: Image.asset(
                'assets/plants/flower.png',
                width: 90,
                height: 90,
                fit: BoxFit.contain,
                errorBuilder: (c, e, s) => const Text('🌸\n🌿', style: TextStyle(fontSize: 48), textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      );
      topEmoji = '☀️';
    }

    return AnimatedBuilder(
      animation: _shakeController,
      builder: (context, child) {
        final val = sin(_shakeController.value * pi * 4);
        return Transform.translate(
          offset: Offset(val * 12, 0),
          child: child,
        );
      },
      child: Center(
        child: SizedBox(
          width: 220,
          height: 220,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // The Pot container
              Container(
                width: 160,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.orange.shade800,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  border: Border.all(color: Colors.orange.shade900, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                  ),
                  child: potContents,
                ),
              ),
              // Top lip of the pot
              Positioned(
                bottom: 110,
                child: Container(
                  width: 180,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade700,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.orange.shade900, width: 3),
                  ),
                ),
              ),
              // If there was an action, show floating hint
              if (topEmoji.isNotEmpty && _currentStep < _maxSteps)
                Positioned(
                  top: 10,
                  child: ScaleTransition(
                    scale: _pulseController.drive(Tween(begin: 1.0, end: 1.2)),
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(topEmoji, style: const TextStyle(fontSize: 20)),
                            const SizedBox(width: 6),
                            const Icon(Icons.check_circle, color: Colors.green, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBE7), // Soft lime background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Grow a Plant',
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
                'Step $_currentStep / $_maxSteps',
                style: AppTextStyles.titleMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Instruction Title Card
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Text(
                    _getInstructionText(),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: Colors.black87,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Drag Target zone (The Pot)
              DragTarget<PlantTool>(
                onWillAcceptWithDetails: (d) => _currentStep < _maxSteps,
                onAcceptWithDetails: (d) => _applyTool(d.data),
                builder: (context, candidateData, rejectedData) {
                  final isHovering = candidateData.isNotEmpty;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isHovering ? Colors.green.withValues(alpha: 0.1) : Colors.transparent,
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: isHovering ? Colors.green : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: _buildPotIllustration(),
                  );
                },
              ),

              const Spacer(),

              // Tools drawer
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Your Tools:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _tools.map((item) {
                      final isNextExpected = _getExpectedToolForStep(_currentStep) == item.tool && _currentStep < _maxSteps;
                      
                      // Highlight the next expected tool with a pulse effect
                      final buttonChild = InkWell(
                        onTap: () => _applyTool(item.tool),
                        borderRadius: BorderRadius.circular(28),
                        child: Container(
                          width: 76,
                          height: 76,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isNextExpected ? item.color : Colors.grey.shade300,
                              width: isNextExpected ? 4 : 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: item.color.withValues(alpha: 0.15),
                                blurRadius: isNextExpected ? 12 : 4,
                                offset: const Offset(0, 3),
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                item.emoji,
                                style: const TextStyle(fontSize: 28),
                              ),
                              Text(
                                item.name,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: item.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );

                      Widget draggableWidget = Draggable<PlantTool>(
                        data: item.tool,
                        feedback: Material(
                          color: Colors.transparent,
                          child: Opacity(
                            opacity: 0.8,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: item.color, width: 4),
                              ),
                              child: Center(
                                child: Text(
                                  item.emoji,
                                  style: const TextStyle(fontSize: 36),
                                ),
                              ),
                            ),
                          ),
                        ),
                        childWhenDragging: Opacity(
                          opacity: 0.3,
                          child: buttonChild,
                        ),
                        child: buttonChild,
                      );

                      if (isNextExpected) {
                        return ScaleTransition(
                          scale: _pulseController.drive(Tween(begin: 1.0, end: 1.06)),
                          child: draggableWidget,
                        );
                      }
                      return draggableWidget;
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
