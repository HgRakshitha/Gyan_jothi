import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/go_to_app_home.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../shared/widgets/quiz_header.dart';
import '../../../../shared/widgets/crescent_border_card.dart';

/// Page for the "Draw a Sun" activity with step-by-step instructions.
class DrawSunPage extends StatelessWidget {
  const DrawSunPage({super.key});

  static const Color _contentBg = Color(0xFFFBFBE4);
  static const Color _dottedLineColor = Color(0xFF5A5A5A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            QuizHeader(
              title: 'Draw a Sun',
              onBack: () => goToAppHome(context),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: DrawSunPage._contentBg,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.black.withValues(alpha: 0.08), width: 1),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.all(24),
                    child: _SingleStepsContent(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: _DoneButton(onPressed: () => context.pop(true)),
            ),
          ],
        ),
      ),
    );
  }
}

/// Steps content that scrolls inside the fixed card container.
class _SingleStepsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step 1
          _StepSection(
            stepNumber: 1,
            instruction: 'Draw a big circle',
            child: Center(child: _DottedCircle(radius: 70)),
          ),
          SizedBox(height: 28),
          // Step 2
          _StepSection(
            stepNumber: 2,
            instruction: 'Add small lines',
            child: Center(child: _DottedSunWithRays(radius: 70)),
          ),
          SizedBox(height: 28),
          // Step 3 - single sun with face
          _StepSection(
            stepNumber: 3,
            instruction: 'Add 2 small circles and smile',
          child: Center(child: _DashedSunFace(radius: 70)),
        ),
      ],
    );
  }
}

class _StepSection extends StatelessWidget {
  final int stepNumber;
  final String instruction;
  final Widget child;

  const _StepSection({
    required this.stepNumber,
    required this.instruction,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Step $stepNumber',
          style: AppTextStyles.bodySmall.copyWith(
            color: const Color(0xFF6B6B6B),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          instruction,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 17,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}

class _DottedCircle extends StatelessWidget {
  final double radius;

  const _DottedCircle({required this.radius});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: CustomPaint(
        painter: _DottedCirclePainter(
          radius: radius,
          color: DrawSunPage._dottedLineColor,
        ),
      ),
    );
  }
}

class _DottedCirclePainter extends CustomPainter {
  final double radius;
  final Color color;

  _DottedCirclePainter({required this.radius, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const dotSpacing = 8.0;
    const dotRadius = 2.0;
    final circumference = 2 * math.pi * radius;
    final dotCount = (circumference / dotSpacing).round();

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (var i = 0; i < dotCount; i++) {
      final angle = (i / dotCount) * 2 * math.pi - math.pi / 2;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DottedSunWithRays extends StatelessWidget {
  final double radius;

  const _DottedSunWithRays({required this.radius});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius * 2 + 80,
      height: radius * 2 + 80,
      child: CustomPaint(
        painter: _DottedSunWithRaysPainter(
          radius: radius,
          color: DrawSunPage._dottedLineColor,
        ),
      ),
    );
  }
}

class _DottedSunWithRaysPainter extends CustomPainter {
  final double radius;
  final Color color;

  _DottedSunWithRaysPainter({required this.radius, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const dotSpacing = 8.0;
    const dotRadius = 2.0;
    const rayCount = 16;
    const rayLength = 25.0;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw dotted circle
    final circumference = 2 * math.pi * radius;
    final dotCount = (circumference / dotSpacing).round();
    for (var i = 0; i < dotCount; i++) {
      final angle = (i / dotCount) * 2 * math.pi - math.pi / 2;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }

    // Draw dotted rays
    for (var i = 0; i < rayCount; i++) {
      final angle = (i / rayCount) * 2 * math.pi - math.pi / 2;
      final startX = center.dx + radius * math.cos(angle);
      final startY = center.dy + radius * math.sin(angle);
      final endX = center.dx + (radius + rayLength) * math.cos(angle);
      final endY = center.dy + (radius + rayLength) * math.sin(angle);

      final dx = endX - startX;
      final dy = endY - startY;
      final length = math.sqrt(dx * dx + dy * dy);
      final dotCountRay = (length / dotSpacing).round().clamp(1, 20);

      for (var j = 0; j < dotCountRay; j++) {
        final t = (j + 1) / (dotCountRay + 1);
        final px = startX + dx * t;
        final py = startY + dy * t;
        canvas.drawCircle(Offset(px, py), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DashedSunFace extends StatelessWidget {
  final double radius;

  const _DashedSunFace({required this.radius});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius * 2 + 80,
      height: radius * 2 + 80,
      child: CustomPaint(
        painter: _DashedSunFacePainter(
          radius: radius,
          color: DrawSunPage._dottedLineColor,
        ),
      ),
    );
  }
}

class _DashedSunFacePainter extends CustomPainter {
  final double radius;
  final Color color;

  _DashedSunFacePainter({required this.radius, required this.color});

  static const double _dashLength = 6.0;
  static const double _gapLength = 4.0;
  static const double _strokeWidth = 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const rayCount = 16;
    const rayLength = 25.0;
    const eyeRadius = 10.0;
    const eyeOffsetY = -15.0;
    const eyeSpacing = 38.0;
    const smileRadius = 22.0;
    const smileOffsetY = 18.0;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round;

    // Dashed circle (body)
    _drawDashedCircle(canvas, center, radius, paint);

    // Dashed rays
    for (var i = 0; i < rayCount; i++) {
      final angle = (i / rayCount) * 2 * math.pi - math.pi / 2;
      final start = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      final end = Offset(
        center.dx + (radius + rayLength) * math.cos(angle),
        center.dy + (radius + rayLength) * math.sin(angle),
      );
      _drawDashedLine(canvas, start, end, paint);
    }

    // Dashed eyes
    final leftEyeCenter = Offset(center.dx - eyeSpacing / 2, center.dy + eyeOffsetY);
    final rightEyeCenter = Offset(center.dx + eyeSpacing / 2, center.dy + eyeOffsetY);
    _drawDashedCircle(canvas, leftEyeCenter, eyeRadius, paint);
    _drawDashedCircle(canvas, rightEyeCenter, eyeRadius, paint);

    // Dashed mouth (opposite direction - curves down)
    final smileCenter = Offset(center.dx, center.dy + smileOffsetY);
    _drawDashedArc(canvas, smileCenter, smileRadius, 0, math.pi, paint);
  }

  void _drawDashedCircle(Canvas canvas, Offset center, double r, Paint paint) {
    final dashAngle = _dashLength / math.max(r, 1);
    final gapAngle = _gapLength / math.max(r, 1);
    var angle = -math.pi / 2;
    const endAngle = 3 * math.pi / 2;

    while (angle < endAngle) {
      final sweep = math.min(dashAngle, endAngle - angle);
      final path = Path()
        ..moveTo(center.dx + r * math.cos(angle), center.dy + r * math.sin(angle))
        ..arcTo(Rect.fromCircle(center: center, radius: r), angle, sweep, false);
      canvas.drawPath(path, paint);
      angle += dashAngle + gapAngle;
    }
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final length = math.sqrt(dx * dx + dy * dy);
    if (length < 1) return;

    final unitX = dx / length;
    final unitY = dy / length;
    var pos = 0.0;

    while (pos < length) {
      final dashEnd = math.min(pos + _dashLength, length);
      canvas.drawLine(
        Offset(start.dx + pos * unitX, start.dy + pos * unitY),
        Offset(start.dx + dashEnd * unitX, start.dy + dashEnd * unitY),
        paint,
      );
      pos += _dashLength + _gapLength;
    }
  }

  void _drawDashedArc(Canvas canvas, Offset center, double r, double startAngle, double endAngle, Paint paint) {
    final segmentAngle = _dashLength / math.max(r, 1);
    final gapAngle = _gapLength / math.max(r, 1);
    var angle = startAngle;

    while (angle < endAngle) {
      final dashEnd = math.min(angle + segmentAngle, endAngle);
      final path = Path()
        ..moveTo(center.dx + r * math.cos(angle), center.dy + r * math.sin(angle))
        ..arcTo(Rect.fromCircle(center: center, radius: r), angle, dashEnd - angle, false);
      canvas.drawPath(path, paint);
      angle += segmentAngle + gapAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DoneButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _DoneButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CrescentBorderCard(
        width: double.infinity,
        height: 72,
        padding: EdgeInsets.zero,
        borderWidth: 3.0,
        innerColor: const Color(0x29DBF226),
        borderGradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(225, 221, 30, 0.2),
            Color(0xFFDBF226),
            Color.fromRGBO(225, 221, 30, 0.2),
          ],
          stops: [0.0002, 0.5029, 0.9998],
        ),
        child: Center(
          child: Text(
            'Done',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
