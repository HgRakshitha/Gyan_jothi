import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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

                // Middle Section: Cat Image & its Shadow Oval
                Expanded(
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        // Highlighted Cat Shadow/Glow (247 x 112)
                        Positioned(
                          bottom: 12,
                          child: Container(
                            width: 247,
                            height: 112,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.elliptical(247 / 2, 112 / 2),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0x00D9D9D9),
                                  Color(0x4CDBF226),
                                ],
                                stops: [0.5046, 0.9889],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x40DBF226),
                                  blurRadius: 31,
                                  spreadRadius: 0,
                                  offset: Offset(6, 13),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Cat Image (238 x 375)
                        Image.asset(
                          'assets/welcome/welcome_cat.png',
                          width: 238,
                          height: 375,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom Content Card (White Card with Rounded Top Corners)
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(48),
                      topRight: Radius.circular(48),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x08000000),
                        blurRadius: 20,
                        offset: Offset(0, -10),
                      ),
                    ],
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
                          // Title
                          const Text(
                            'Welcome',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Subtitle
                          const Text(
                            'A magical world where you can play,\nlearn, and grow!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Custom Styled Next Button (302 x 60)
                          GestureDetector(
                            onTap: () => context.go(AppRoutes.home),
                            child: CustomPaint(
                              painter: NextButtonBorderPainter(strokeWidth: 3.0),
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
                            children: [
                              // Active (tall) bar
                              Container(
                                width: 4,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDBF226),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                              const SizedBox(width: 6),
                              // Inactive (short) bars
                              ...List.generate(3, (index) => Container(
                                width: 4,
                                height: 12,
                                margin: const EdgeInsets.only(left: 6),
                                decoration: BoxDecoration(
                                  color: const Color(0x4CDBF226),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              )),
                            ],
                          ),
                          const SizedBox(height: 12),
                        ],
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
class NextButtonBorderPainter extends CustomPainter {
  final double strokeWidth;

  NextButtonBorderPainter({required this.strokeWidth});

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
