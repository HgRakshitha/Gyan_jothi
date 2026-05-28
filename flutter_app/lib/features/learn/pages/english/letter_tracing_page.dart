import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../shared/providers/user_provider.dart';
import '../../../../shared/widgets/custom_button.dart';

class LetterTracingPage extends ConsumerStatefulWidget {
  const LetterTracingPage({super.key});

  @override
  ConsumerState<LetterTracingPage> createState() => _LetterTracingPageState();
}

class _LetterTracingPageState extends ConsumerState<LetterTracingPage> {
  int _currentLetterIndex = 0;
  final List<Offset?> _points = [];
  
  final List<String> _letters = List.generate(26, (index) => String.fromCharCode(65 + index));

  void _nextLetter() {
    if (_currentLetterIndex < _letters.length - 1) {
      setState(() {
        _currentLetterIndex++;
        _points.clear();
      });
    } else {
      _finishActivity();
    }
  }

  void _previousLetter() {
    if (_currentLetterIndex > 0) {
      setState(() {
        _currentLetterIndex--;
        _points.clear();
      });
    }
  }

  void _clearCanvas() {
    setState(() {
      _points.clear();
    });
  }

  void _finishActivity() {
    // Award coins and return
    final success = ref.read(userProvider.notifier).completeActivity('learn_Letter Tracing', 30);
    if (success) {
      context.pushReplacement(AppRoutes.taskCompletion, extra: 30);
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLetter = _letters[_currentLetterIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Letter Tracing',
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
              'Trace the letter',
              style: AppTextStyles.headlineMedium,
            ),
            const SizedBox(height: 30),
            
            // Canvas Area
            Expanded(
              child: Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Background letter
                      Center(
                        child: Text(
                          currentLetter,
                          style: TextStyle(
                            fontSize: 200,
                            fontWeight: FontWeight.w900,
                            color: Colors.grey.withValues(alpha: 0.15),
                            height: 1.0,
                          ),
                        ),
                      ),
                      
                      // 4-line guide lines
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _FourLineGuidePainter(),
                        ),
                      ),
                      
                      // Drawing canvas
                      Positioned.fill(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onPanStart: (details) {
                            setState(() {
                              _points.add(details.localPosition);
                            });
                          },
                          onPanUpdate: (details) {
                            setState(() {
                              _points.add(details.localPosition);
                            });
                          },
                          onPanEnd: (details) {
                            setState(() {
                              _points.add(null);
                            });
                          },
                          child: CustomPaint(
                            painter: _TracingPainter(points: _points),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Controls
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _previousLetter,
                    icon: const Icon(Icons.arrow_back_rounded),
                    color: _currentLetterIndex > 0 ? Colors.black87 : Colors.black26,
                    iconSize: 32,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomButton(
                        label: 'Clear',
                        onTap: _clearCanvas,
                        backgroundColor: Colors.grey.shade300,
                        textColor: Colors.black87,
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      label: _currentLetterIndex < _letters.length - 1 ? 'Next' : 'Finish',
                      onTap: _nextLetter,
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
}

class _TracingPainter extends CustomPainter {
  final List<Offset?> points;

  _TracingPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.primary
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _TracingPainter oldDelegate) {
    return true;
  }
}

class _FourLineGuidePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintRed = Paint()
      ..color = Colors.red.withValues(alpha: 0.3)
      ..strokeWidth = 2.0;
      
    final paintBlue = Paint()
      ..color = Colors.blue.withValues(alpha: 0.3)
      ..strokeWidth = 2.0;

    final stepY = size.height / 5;
    
    // Top red line
    canvas.drawLine(Offset(0, stepY * 1), Offset(size.width, stepY * 1), paintRed);
    // Middle blue lines
    canvas.drawLine(Offset(0, stepY * 2), Offset(size.width, stepY * 2), paintBlue);
    canvas.drawLine(Offset(0, stepY * 3), Offset(size.width, stepY * 3), paintBlue);
    // Bottom red line
    canvas.drawLine(Offset(0, stepY * 4), Offset(size.width, stepY * 4), paintRed);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
