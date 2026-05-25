import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/go_to_app_home.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../shared/widgets/quiz_header.dart';
import '../../../../shared/widgets/crescent_border_card.dart';

/// Page for the "Draw a Home" activity with step-by-step instructions.
class DrawHomePage extends StatelessWidget {
  const DrawHomePage({super.key});

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
              title: 'Draw a Home',
              onBack: () => goToAppHome(context),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: DrawHomePage._contentBg,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.black.withValues(alpha: 0.08), width: 1),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.all(24),
                    child: _HomeStepsContent(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: _DoneButton(onPressed: () => context.pop()),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeStepsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StepSection(
          stepNumber: 1,
          instruction: 'Draw a big rectangle',
          child: Center(child: _HomeStep1Rect()),
        ),
        SizedBox(height: 28),
        _StepSection(
          stepNumber: 2,
          instruction: 'Draw a triangle on top (roof)',
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(child: _HomeStep2WithRoof()),
          ),
        ),
        SizedBox(height: 28),
        _StepSection(
          stepNumber: 3,
          instruction: 'Draw a small rectangle (door)',
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(child: _HomeStep3WithDoor()),
          ),
        ),
        SizedBox(height: 28),
        _StepSection(
          stepNumber: 4,
          instruction: 'Draw two small squares (windows)',
          child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(child: _HomeStep4WithWindows()),
          ),
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

class _HomeDimensions {
  static const double width = 200.0;
  static const double height = 138.0;
  static const double rectLeft = 35.0;
  static const double rectTop = 52.0;
  static const double rectWidth = 130.0;  // Wider rectangle
  static const double rectHeight = 72.0;  // Taller house
  static const double rectRight = rectLeft + rectWidth;
  static const double rectBottom = rectTop + rectHeight;
  static const double triangleBaseY = rectTop;   // Same base: share horizontal baseline
  static const double triangleExtension = 30.0;  // Wider triangle - extends beyond rectangle
  static const double triangleLeftX = rectLeft - triangleExtension;
  static const double triangleRightX = rectRight + triangleExtension;
  static const double roofPeakY = -22.0;  // Taller triangle (bigger house)
  static const double doorWidth = 28.0;
  static const double doorHeight = 44.0;
  static const double doorLeft = (rectLeft + rectRight) / 2 - doorWidth / 2;
  static const double doorTop = rectBottom - doorHeight - 6;
  static const double windowSize = 22.0;
  static const double windowY = doorTop + 8;
  static const double leftWindowX = doorLeft - windowSize - 12;
  static const double rightWindowX = doorLeft + doorWidth + 12;
}

class _HomeStep1Rect extends StatelessWidget {
  const _HomeStep1Rect();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _HomeDimensions.width,
      height: _HomeDimensions.height,
      child: CustomPaint(
        painter: _HomeRectPainter(color: DrawHomePage._lineColor),
      ),
    );
  }
}

class _HomeRectPainter extends CustomPainter {
  final Color color;

  _HomeRectPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.fill;
    final path = Path()
      ..addRect(const Rect.fromLTWH(
        _HomeDimensions.rectLeft,
        _HomeDimensions.rectTop,
        _HomeDimensions.rectWidth,
        _HomeDimensions.rectHeight,
      ));
    _drawDottedPath(canvas, path, paint);
  }

  void _drawDottedPath(Canvas canvas, Path path, Paint paint) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final pos = metric.getTangentForOffset(distance)?.position ?? Offset.zero;
        canvas.drawCircle(pos, DrawHomePage._dotRadius, paint);
        distance += DrawHomePage._dotSpacing;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HomeStep2WithRoof extends StatelessWidget {
  const _HomeStep2WithRoof();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _HomeDimensions.width,
      height: _HomeDimensions.height,
      child: CustomPaint(
        painter: _HomeWithRoofPainter(color: DrawHomePage._lineColor),
      ),
    );
  }
}

class _HomeWithRoofPainter extends CustomPainter {
  final Color color;

  _HomeWithRoofPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.fill;
    final rectPath = Path()
      ..addRect(const Rect.fromLTWH(
        _HomeDimensions.rectLeft,
        _HomeDimensions.rectTop,
        _HomeDimensions.rectWidth,
        _HomeDimensions.rectHeight,
      ));
    final trianglePath = Path()
      ..moveTo(_HomeDimensions.triangleLeftX, _HomeDimensions.triangleBaseY)
      ..lineTo((_HomeDimensions.rectLeft + _HomeDimensions.rectRight) / 2, _HomeDimensions.roofPeakY)
      ..lineTo(_HomeDimensions.triangleRightX, _HomeDimensions.triangleBaseY)
      ..close();
    _drawDottedPath(canvas, rectPath, paint);
    _drawDottedPath(canvas, trianglePath, paint);
  }

  void _drawDottedPath(Canvas canvas, Path path, Paint paint) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final pos = metric.getTangentForOffset(distance)?.position ?? Offset.zero;
        canvas.drawCircle(pos, DrawHomePage._dotRadius, paint);
        distance += DrawHomePage._dotSpacing;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HomeStep3WithDoor extends StatelessWidget {
  const _HomeStep3WithDoor();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _HomeDimensions.width,
      height: _HomeDimensions.height,
      child: CustomPaint(
        painter: _HomeWithDoorPainter(color: DrawHomePage._lineColor),
      ),
    );
  }
}

class _HomeWithDoorPainter extends CustomPainter {
  final Color color;

  _HomeWithDoorPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.fill;
    final rectPath = Path()
      ..addRect(const Rect.fromLTWH(
        _HomeDimensions.rectLeft,
        _HomeDimensions.rectTop,
        _HomeDimensions.rectWidth,
        _HomeDimensions.rectHeight,
      ));
    final trianglePath = Path()
      ..moveTo(_HomeDimensions.triangleLeftX, _HomeDimensions.triangleBaseY)
      ..lineTo((_HomeDimensions.rectLeft + _HomeDimensions.rectRight) / 2, _HomeDimensions.roofPeakY)
      ..lineTo(_HomeDimensions.triangleRightX, _HomeDimensions.triangleBaseY)
      ..close();
    final doorPath = Path()
      ..addRect(const Rect.fromLTWH(
        _HomeDimensions.doorLeft,
        _HomeDimensions.doorTop,
        _HomeDimensions.doorWidth,
        _HomeDimensions.doorHeight,
      ));
    _drawDottedPath(canvas, rectPath, paint);
    _drawDottedPath(canvas, trianglePath, paint);
    _drawDottedPath(canvas, doorPath, paint);
  }

  void _drawDottedPath(Canvas canvas, Path path, Paint paint) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final pos = metric.getTangentForOffset(distance)?.position ?? Offset.zero;
        canvas.drawCircle(pos, DrawHomePage._dotRadius, paint);
        distance += DrawHomePage._dotSpacing;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HomeStep4WithWindows extends StatelessWidget {
  const _HomeStep4WithWindows();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _HomeDimensions.width,
      height: _HomeDimensions.height,
      child: CustomPaint(
        painter: _HomeWithWindowsPainter(color: DrawHomePage._lineColor),
      ),
    );
  }
}

class _HomeWithWindowsPainter extends CustomPainter {
  final Color color;

  _HomeWithWindowsPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.fill;
    final rectPath = Path()
      ..addRect(const Rect.fromLTWH(
        _HomeDimensions.rectLeft,
        _HomeDimensions.rectTop,
        _HomeDimensions.rectWidth,
        _HomeDimensions.rectHeight,
      ));
    final trianglePath = Path()
      ..moveTo(_HomeDimensions.triangleLeftX, _HomeDimensions.triangleBaseY)
      ..lineTo((_HomeDimensions.rectLeft + _HomeDimensions.rectRight) / 2, _HomeDimensions.roofPeakY)
      ..lineTo(_HomeDimensions.triangleRightX, _HomeDimensions.triangleBaseY)
      ..close();
    final doorPath = Path()
      ..addRect(const Rect.fromLTWH(
        _HomeDimensions.doorLeft,
        _HomeDimensions.doorTop,
        _HomeDimensions.doorWidth,
        _HomeDimensions.doorHeight,
      ));
    final leftWindowPath = Path()
      ..addRect(const Rect.fromLTWH(
        _HomeDimensions.leftWindowX,
        _HomeDimensions.windowY,
        _HomeDimensions.windowSize,
        _HomeDimensions.windowSize,
      ));
    final rightWindowPath = Path()
      ..addRect(const Rect.fromLTWH(
        _HomeDimensions.rightWindowX,
        _HomeDimensions.windowY,
        _HomeDimensions.windowSize,
        _HomeDimensions.windowSize,
      ));
    _drawDottedPath(canvas, rectPath, paint);
    _drawDottedPath(canvas, trianglePath, paint);
    _drawDottedPath(canvas, doorPath, paint);
    _drawDottedPath(canvas, leftWindowPath, paint);
    _drawDottedPath(canvas, rightWindowPath, paint);
  }

  void _drawDottedPath(Canvas canvas, Path path, Paint paint) {
    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final pos = metric.getTangentForOffset(distance)?.position ?? Offset.zero;
        canvas.drawCircle(pos, DrawHomePage._dotRadius, paint);
        distance += DrawHomePage._dotSpacing;
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
