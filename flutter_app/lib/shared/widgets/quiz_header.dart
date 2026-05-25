import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class QuizHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  /// Defaults to [AppSizes.yellowHeaderHeight] for a consistent top bar app-wide.
  final double height;
  final VoidCallback? onBack;
  final EdgeInsetsGeometry margin;
  /// When set, replaces the default lime-yellow header gradient.
  final List<Color>? gradientColors;
  final bool showBackButton;

  const QuizHeader({
    super.key,
    this.title = 'Quiz',
    this.subtitle,
    this.height = AppSizes.yellowHeaderHeight,
    this.onBack,
    this.margin = EdgeInsets.zero,
    this.gradientColors,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    // viewPadding: status bar / notch even when drawing edge-to-edge (padding.top can be 0).
    final topPad = MediaQuery.viewPaddingOf(context).top;

    return Padding(
      padding: margin,
      child: PhysicalShape(
        clipper: const _QuizHeaderClipper(),
        color: Colors.transparent,
        shadowColor: const Color(0x22000000),
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        child: CustomPaint(
          foregroundPainter: const _QuizHeaderBorderPainter(),
          child: ClipPath(
            clipper: const _QuizHeaderClipper(),
            child: Container(
              width: double.infinity,
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientColors ??
                      const [
                        Color(0xFFE8F55D), // Top: Light lime-yellow
                        Color(0xFFDBF226), // Bottom: Darker lime-yellow
                      ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(22, topPad + 18, 22, 0),
                child: Row(
                  children: [
                    if (showBackButton)
                      _HeaderBackButton(onTap: onBack ?? () => Navigator.of(context).maybePop()),
                    if (!showBackButton)
                      const SizedBox(width: 42), // Keep symmetry if back button is hidden
                    Expanded(
                      child: Center(
                        child: subtitle != null
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    subtitle!,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      height: 1.2,
                                      color: AppColors.textPrimary.withValues(alpha: 0.92),
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(width: 42),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuizHeaderBorderPainter extends CustomPainter {
  const _QuizHeaderBorderPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final path = const _QuizHeaderClipper().getClip(size);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0 // Draw 2px so 1px is visible inside the clip
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color.fromRGBO(225, 221, 30, 0.14),
          Color(0xFFE1DD1E),
          Color.fromRGBO(225, 221, 30, 0.14),
        ],
        stops: [0.0322, 0.5014, 0.9652],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HeaderBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const _HeaderBackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.18),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
        ),
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _QuizHeaderClipper extends CustomClipper<Path> {
  const _QuizHeaderClipper();

  @override
  Path getClip(Size size) {
    final path = Path();
    const double bottomRadius = 40.0;
    final double bottomY = size.height;
    final double peakY = size.height - 20; // Shallower curve (approx 20px dip)
    final double w = size.width;

    // Control point factor for smooth bezier transition
    const double alpha = 0.55; 
    final double halfW = w * 0.5;
    final double segmentWidth = halfW - bottomRadius;

    // Square top so lime fills the status-bar corners; bottom = rounded sides + smooth center wave curve.
    path.moveTo(0, 0);
    path.lineTo(w, 0);
    path.lineTo(w, bottomY - bottomRadius);
    path.quadraticBezierTo(w, bottomY, w - bottomRadius, bottomY);

    // Cubic curve from right side to middle
    path.cubicTo(
      w - bottomRadius - alpha * segmentWidth, bottomY,
      halfW + alpha * segmentWidth, peakY,
      halfW, peakY,
    );

    // Cubic curve from middle to left side
    path.cubicTo(
      halfW - alpha * segmentWidth, peakY,
      bottomRadius + alpha * segmentWidth, bottomY,
      bottomRadius, bottomY,
    );

    path.quadraticBezierTo(0, bottomY, 0, bottomY - bottomRadius);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
