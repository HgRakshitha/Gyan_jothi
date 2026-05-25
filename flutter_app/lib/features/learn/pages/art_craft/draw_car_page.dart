import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/go_to_app_home.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../shared/widgets/quiz_header.dart';
import '../../../../shared/widgets/crescent_border_card.dart';

/// Page for the "Draw a Car" activity with step-by-step instructions.
class DrawCarPage extends StatelessWidget {
  const DrawCarPage({super.key});

  static const Color _contentBg = Color(0xFFFBFBE4);
  static const Color _lineColor = Color(0xFF5A5A5A);
  static const double _dotSpacing = 8.0;
  static const double _dotRadius = 2.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            QuizHeader(
              title: 'Draw a Car',
              onBack: () => goToAppHome(context),
            ),
            Expanded(
child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: DrawCarPage._contentBg,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.black.withValues(alpha: 0.08), width: 1),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    child: _CarStepsContent(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
              child: _DoneButton(onPressed: () => context.pop(true)),
            ),
          ],
        ),
      ),
    );
  }
}

class _CarStepsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StepSection(
          stepNumber: 1,
          instruction: 'Draw a big curved line',
          child: Padding(
            padding: EdgeInsets.only(top: 16),
            child: Center(child: _CarStep1Arc()),
          ),
        ),
        SizedBox(height: 8),
        _StepSection(
          stepNumber: 2,
          instruction: 'Draw a long straight line under it to make the car body',
          child: Padding(
            padding: EdgeInsets.only(top: 8),
            child: Center(child: _CarStep2Body()),
          ),
        ),
        SizedBox(height: 28),
        _StepSection(
          stepNumber: 3,
          instruction: 'Add two big circles at the bottom (wheels)',
          topSpacing: 16,
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Center(child: _CarStep3WithWheels()),
          ),
        ),
        SizedBox(height: 28),
        _StepSection(
          stepNumber: 4,
          instruction: 'Add two small rounded rectangles (windows)',
          topSpacing: 16,
          child: Center(child: _CarStep4WithWindows()),
        ),
      ],
    );
  }
}

class _StepSection extends StatelessWidget {
  final int stepNumber;
  final String instruction;
  final Widget child;
  final double topSpacing;

  const _StepSection({
    required this.stepNumber,
    required this.instruction,
    required this.child,
    this.topSpacing = 8,
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
        SizedBox(height: topSpacing),
        child,
      ],
    );
  }
}

/// Shared car dimensions - all steps use these for visual continuity.
/// U-shaped curve (roof) on top, bulging upward; curve extends slightly beyond rounded body ends.
class _CarDimensions {
  static const double width = 200.0;
  static const double height = 128.0;  // Taller to fit car moved down
  static const double centerX = 100.0;
  static const double halfCircleRadius = 52.0;  // Curve size
  static const double halfCircleCenterY = 46.0;  // Arc center; moved lower to reduce top gap
  static const double rectWidth = 140.0;
  static const double rectHeight = 42.0;
  static const double rectTopY = 46.0;  // Body top aligns with arc bottom chord
  static const double rectLeft = centerX - rectWidth / 2;
  static const double rectRight = centerX + rectWidth / 2;
  static const double rectBottomY = rectTopY + rectHeight;
  static const double bodyCornerRadius = 11.0;
  static const double wheelRadius = 22.0;
  static const double leftWheelX = 65.0;
  static const double rightWheelX = 135.0;
  static const double wheelY = 103.0;  // Below body (moved down with curve/body)
  static const double step1Height = 62.0;   // Shorter to reduce gap below curve
  static const double step2Height = 102.0;  // Shorter to reduce gap below body
}

class _CarStep1Arc extends StatelessWidget {
  const _CarStep1Arc();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _CarDimensions.width,
      height: _CarDimensions.step1Height,
      child: CustomPaint(
        painter: _CarArcPainter(color: DrawCarPage._lineColor),
      ),
    );
  }
}

class _CarArcPainter extends CustomPainter {
  final Color color;

  _CarArcPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.fill;
    const center = Offset(_CarDimensions.centerX, _CarDimensions.halfCircleCenterY);
    final rect = Rect.fromCircle(center: center, radius: _CarDimensions.halfCircleRadius);
    final arcPath = Path()..addArc(rect, math.pi, math.pi);
    _drawDottedPath(canvas, arcPath, paint);
  }

  void _drawDottedPath(Canvas canvas, Path path, Paint paint) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final pos = metric.getTangentForOffset(distance)?.position ?? Offset.zero;
        canvas.drawCircle(pos, DrawCarPage._dotRadius, paint);
        distance += DrawCarPage._dotSpacing;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CarStep2Body extends StatelessWidget {
  const _CarStep2Body();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _CarDimensions.width,
      height: _CarDimensions.step2Height,
      child: CustomPaint(
        painter: _CarBodyPainter(color: DrawCarPage._lineColor),
      ),
    );
  }
}

class _CarBodyPainter extends CustomPainter {
  final Color color;

  _CarBodyPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.fill;
    const center = Offset(_CarDimensions.centerX, _CarDimensions.halfCircleCenterY);
    final rect = Rect.fromCircle(center: center, radius: _CarDimensions.halfCircleRadius);
    final arcPath = Path()..addArc(rect, math.pi, math.pi);
    final bodyRect = RRect.fromRectAndRadius(
      const Rect.fromLTRB(
        _CarDimensions.rectLeft,
        _CarDimensions.rectTopY,
        _CarDimensions.rectRight,
        _CarDimensions.rectBottomY,
      ),
      const Radius.circular(_CarDimensions.bodyCornerRadius),
    );
    _drawDottedPath(canvas, arcPath, paint);
    _drawDottedPath(canvas, Path()..addRRect(bodyRect), paint);
  }

  void _drawDottedPath(Canvas canvas, Path path, Paint paint) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final pos = metric.getTangentForOffset(distance)?.position ?? Offset.zero;
        canvas.drawCircle(pos, DrawCarPage._dotRadius, paint);
        distance += DrawCarPage._dotSpacing;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CarStep3WithWheels extends StatelessWidget {
  const _CarStep3WithWheels();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _CarDimensions.width,
      height: _CarDimensions.height,
      child: CustomPaint(
        painter: _CarWithWheelsPainter(color: DrawCarPage._lineColor),
      ),
    );
  }
}

class _CarWithWheelsPainter extends CustomPainter {
  final Color color;

  _CarWithWheelsPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.fill;
    const center = Offset(_CarDimensions.centerX, _CarDimensions.halfCircleCenterY);
    final arcRect = Rect.fromCircle(center: center, radius: _CarDimensions.halfCircleRadius);
    final arcPath = Path()..addArc(arcRect, math.pi, math.pi);
    final bodyPath = Path()..addRRect(RRect.fromRectAndRadius(
      const Rect.fromLTRB(
        _CarDimensions.rectLeft,
        _CarDimensions.rectTopY,
        _CarDimensions.rectRight,
        _CarDimensions.rectBottomY,
      ),
      const Radius.circular(_CarDimensions.bodyCornerRadius),
    ));
    final wheelCenters = [
      const Offset(_CarDimensions.leftWheelX, _CarDimensions.wheelY),
      const Offset(_CarDimensions.rightWheelX, _CarDimensions.wheelY),
    ];
    _drawDottedPath(canvas, arcPath, paint);
    _drawDottedPathExcludingCircles(canvas, bodyPath, wheelCenters, paint);

    final leftWheel = Path()..addOval(Rect.fromCircle(
      center: const Offset(_CarDimensions.leftWheelX, _CarDimensions.wheelY),
      radius: _CarDimensions.wheelRadius,
    ));
    final rightWheel = Path()..addOval(Rect.fromCircle(
      center: const Offset(_CarDimensions.rightWheelX, _CarDimensions.wheelY),
      radius: _CarDimensions.wheelRadius,
    ));
    _drawDottedPath(canvas, leftWheel, paint);
    _drawDottedPath(canvas, rightWheel, paint);
  }

  void _drawDottedPathExcludingCircles(
    Canvas canvas,
    Path path,
    List<Offset> circleCenters,
    Paint paint,
  ) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final pos = metric.getTangentForOffset(distance)?.position ?? Offset.zero;
        final insideWheel = circleCenters.any((c) =>
          (pos - c).distance <= _CarDimensions.wheelRadius);
        if (!insideWheel) {
          canvas.drawCircle(pos, DrawCarPage._dotRadius, paint);
        }
        distance += DrawCarPage._dotSpacing;
      }
    }
  }

  void _drawDottedPath(Canvas canvas, Path path, Paint paint) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final pos = metric.getTangentForOffset(distance)?.position ?? Offset.zero;
        canvas.drawCircle(pos, DrawCarPage._dotRadius, paint);
        distance += DrawCarPage._dotSpacing;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CarStep4WithWindows extends StatelessWidget {
  const _CarStep4WithWindows();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _CarDimensions.width,
      height: _CarDimensions.height,
      child: CustomPaint(
        painter: _CarWithWindowsPainter(color: DrawCarPage._lineColor),
      ),
    );
  }
}

class _CarWithWindowsPainter extends CustomPainter {
  final Color color;

  _CarWithWindowsPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.fill;
    const center = Offset(_CarDimensions.centerX, _CarDimensions.halfCircleCenterY);
    final arcRect = Rect.fromCircle(center: center, radius: _CarDimensions.halfCircleRadius);
    final arcPath = Path()..addArc(arcRect, math.pi, math.pi);
    final bodyPath = Path()..addRRect(RRect.fromRectAndRadius(
      const Rect.fromLTRB(
        _CarDimensions.rectLeft,
        _CarDimensions.rectTopY,
        _CarDimensions.rectRight,
        _CarDimensions.rectBottomY,
      ),
      const Radius.circular(_CarDimensions.bodyCornerRadius),
    ));
    final wheelCenters = [
      const Offset(_CarDimensions.leftWheelX, _CarDimensions.wheelY),
      const Offset(_CarDimensions.rightWheelX, _CarDimensions.wheelY),
    ];
    _drawDottedPath(canvas, arcPath, paint);
    _drawDottedPathExcludingCircles(canvas, bodyPath, wheelCenters, paint);

    final leftWheel = Path()..addOval(Rect.fromCircle(
      center: const Offset(_CarDimensions.leftWheelX, _CarDimensions.wheelY),
      radius: _CarDimensions.wheelRadius,
    ));
    final rightWheel = Path()..addOval(Rect.fromCircle(
      center: const Offset(_CarDimensions.rightWheelX, _CarDimensions.wheelY),
      radius: _CarDimensions.wheelRadius,
    ));
    _drawDottedPath(canvas, leftWheel, paint);
    _drawDottedPath(canvas, rightWheel, paint);

    const innerArcRadius = 32.0;
    const innerArcCenterY = 38.0;  // Small curve lower in roof (closer to body)
    const innerArcCenter = Offset(_CarDimensions.centerX, innerArcCenterY);
    final innerArcRect = Rect.fromCircle(center: innerArcCenter, radius: innerArcRadius);
    final innerCurve = Path()..addArc(innerArcRect, math.pi, math.pi);
    _drawDottedPath(canvas, innerCurve, paint);

    final parallelLine = Path()
      ..moveTo(_CarDimensions.centerX - innerArcRadius, innerArcCenterY)
      ..lineTo(_CarDimensions.centerX + innerArcRadius, innerArcCenterY);
    _drawDottedPath(canvas, parallelLine, paint);

    final verticalLineTop = innerArcCenter.dy - innerArcRadius;
    final verticalLineBottom = innerArcCenter.dy;
    final verticalLine = Path()
      ..moveTo(_CarDimensions.centerX, verticalLineTop)
      ..lineTo(_CarDimensions.centerX, verticalLineBottom);
    _drawDottedPath(canvas, verticalLine, paint);
  }

  void _drawDottedPathExcludingCircles(
    Canvas canvas,
    Path path,
    List<Offset> circleCenters,
    Paint paint,
  ) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final pos = metric.getTangentForOffset(distance)?.position ?? Offset.zero;
        final insideWheel = circleCenters.any((c) =>
          (pos - c).distance <= _CarDimensions.wheelRadius);
        if (!insideWheel) {
          canvas.drawCircle(pos, DrawCarPage._dotRadius, paint);
        }
        distance += DrawCarPage._dotSpacing;
      }
    }
  }

  void _drawDottedPath(Canvas canvas, Path path, Paint paint) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final pos = metric.getTangentForOffset(distance)?.position ?? Offset.zero;
        canvas.drawCircle(pos, DrawCarPage._dotRadius, paint);
        distance += DrawCarPage._dotSpacing;
      }
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
