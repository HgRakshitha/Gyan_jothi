import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/widgets/top_wave_clipper.dart';

class WelcomeFoxPage extends StatelessWidget {
  const WelcomeFoxPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient (170.45deg, #DBF226 to #FFFFFF)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                // 170.45 deg is roughly from top-center (slightly right) to bottom-center (slightly left)
                begin: Alignment(0.166, -1.0),
                end: Alignment(-0.166, 1.0),
                colors: [
                  Color(0xFFDBF226),
                  Color(0xFFFFFFFF),
                ],
                stops: [-0.1817, 1.1472],
              ),
            ),
          ),

          // Backdrop filter for smooth background blur (100px)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
            child: const SizedBox.expand(),
          ),

          // Main Layout Content
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // Top Action Bar with Skip Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => context.go(AppRoutes.home),
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Middle Section: Fox Image & its Shadow
                Expanded(
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        // Fox-shaped Gradient Drop Shadow (Darker at bottom)
                        Transform.translate(
                          offset: const Offset(6, 13),
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(sigmaX: 15.5, sigmaY: 15.5),
                            child: ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0x20DBF226), // Light yellow at top
                                  Color(0x708A960B), // Darker yellow-green at bottom
                                ],
                                stops: [0.3, 1.0],
                              ).createShader(bounds),
                              blendMode: BlendMode.srcIn,
                              child: Image.asset(
                                'assets/welcome/welcome_fox.png',
                                width: 360,
                                height: 504,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),

                        // Fox Image
                        Image.asset(
                          'assets/welcome/welcome_fox.png',
                          width: 360,
                          height: 504,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom Content Card (White Card with TopWaveClipper)
                ClipPath(
                  clipper: const TopWaveClipper(),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: SafeArea(
                      top: false,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 32.0,
                          right: 32.0,
                          top: 40.0,
                          bottom: 24.0,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Text Block (Width 312, Gap 12)
                            SizedBox(
                              width: 312,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Title
                                  const Text(
                                    'Ready to Begin?',
                                    style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 12), // gap: 12px

                                  // Subtitle
                                  const Text(
                                    'Set up your profile, pick your favorite\ncharacter, and start your learning\nadventure!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black54,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Custom Styled Next Button (302 x 60)
                            GestureDetector(
                              onTap: () => context.go(AppRoutes.welcomeFinal),
                              child: CustomPaint(
                                painter: FoxNextButtonBorderPainter(strokeWidth: 3.0),
                                child: Container(
                                  width: 302,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                    gradient: LinearGradient(
                                      begin: Alignment(-0.8, -0.6),
                                      end: Alignment(0.8, 0.6),
                                      colors: [
                                        Color(0xBCECFF52),
                                        Color(0xBCF0FE7F),
                                        Color(0xBCDCF32C),
                                      ],
                                      stops: [0.1333, 0.2484, 0.4654],
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Next',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 36),

                            // Custom Page Indicator Bars (||||)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(4, (index) {
                                final isActive = index == 3; // 4th bar is active
                                return Container(
                                  width: 4,
                                  height: isActive ? 24 : 12,
                                  margin: EdgeInsets.only(left: index == 0 ? 0 : 6),
                                  decoration: BoxDecoration(
                                    color: isActive
                                        ? const Color(0xFFDBF226)
                                        : const Color(0x4CDBF226),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for Left/Right Gradient Borders only (border-width: 0px 3px 0px 3px)
class FoxNextButtonBorderPainter extends CustomPainter {
  final double strokeWidth;

  FoxNextButtonBorderPainter({required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0x33E1DD1E), // rgba(225, 221, 30, 0.2)
          Color(0xFFDBF226), // #DBF226
          Color(0x33E1DD1E), // rgba(225, 221, 30, 0.2)
        ],
        stops: [0.0002, 0.5029, 0.9998],
      ).createShader(rect);

    final h = size.height;
    final w = size.width;

    // Draw left semi-circle arc of the capsule shape
    final leftRect = Rect.fromLTWH(0, 0, h, h);
    final leftPath = Path()..addArc(leftRect, 0.5 * math.pi, math.pi);
    canvas.drawPath(leftPath, paint);

    // Draw right semi-circle arc of the capsule shape
    final rightRect = Rect.fromLTWH(w - h, 0, h, h);
    final rightPath = Path()..addArc(rightRect, 1.5 * math.pi, math.pi);
    canvas.drawPath(rightPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
