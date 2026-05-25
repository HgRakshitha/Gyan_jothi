import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';

class WelcomeFinalPage extends StatelessWidget {
  const WelcomeFinalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDBF226),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: 700, // Exact height from design spec
              width: double.infinity,
              child: CustomPaint(
                painter: DoubleWaveShadowPainter(),
                foregroundPainter: DoubleWaveBorderPainter(),
                child: ClipPath(
                  clipper: DoubleWaveClipper(),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 45, sigmaY: 45), // 90px blur
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo
                          Image.asset(
                            'assets/icons/home/GJ.png',
                            width: 140,
                            height: 140,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                              Icons.school,
                              size: 140,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 32),
                          
                          // Title
                          const Text(
                            'Gyan Jyoti\nEducation Hub',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          
                          // Subtitle
                          const Text(
                            'Where learning is an adventure!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54,
                            ),
                          ),
                          
                          const Spacer(),
                          
                          // "Let's Start!" Button
                          GestureDetector(
                            onTap: () => context.go(AppRoutes.welcomeName),
                            child: CustomPaint(
                              painter: LetsStartButtonBorderPainter(),
                              child: Container(
                                width: 302,
                                height: 60,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFBFBE4),
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Let's Start!",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DoubleWavePath {
  static Path getPath(Size size) {
    final path = Path();
    const double radius = 66.0;
    const double dipDepth = 12.0;

    // Top edge (left to right)
    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius + 10, 0);
    path.lineTo(size.width * 0.10, 0);
    path.cubicTo(
      size.width * 0.20, 0,
      size.width * 0.30, dipDepth * 0.06,
      size.width * 0.40, dipDepth * 0.50,
    );
    path.cubicTo(
      size.width * 0.45, dipDepth * 0.82,
      size.width * 0.50, dipDepth,
      size.width * 0.55, dipDepth * 0.82,
    );
    path.cubicTo(
      size.width * 0.70, dipDepth * 0.06,
      size.width * 0.80, 0,
      size.width * 0.90, 0,
    );
    path.lineTo(size.width - radius - 10, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    // Bottom edge (right to left)
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(size.width, size.height, size.width - radius - 10, size.height);
    path.lineTo(size.width * 0.90, size.height);
    path.cubicTo(
      size.width * 0.80, size.height,
      size.width * 0.70, size.height - dipDepth * 0.06,
      size.width * 0.55, size.height - dipDepth * 0.82,
    );
    path.cubicTo(
      size.width * 0.50, size.height - dipDepth,
      size.width * 0.45, size.height - dipDepth * 0.82,
      size.width * 0.40, size.height - dipDepth * 0.50,
    );
    path.cubicTo(
      size.width * 0.30, size.height - dipDepth * 0.06,
      size.width * 0.20, size.height,
      size.width * 0.10, size.height,
    );
    path.lineTo(radius + 10, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    path.close();
    return path;
  }
}

class DoubleWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return DoubleWavePath.getPath(size);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class DoubleWaveShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = DoubleWavePath.getPath(size);

    canvas.drawPath(
      path.shift(const Offset(0, -20)),
      Paint()
        ..color = const Color(0x29957642)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DoubleWaveBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = DoubleWavePath.getPath(size);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..shader = const LinearGradient(
        colors: [
          Color(0x24E1DD1E), // 0.14 opacity
          Color(0xFFE1DD1E),
          Color(0x24E1DD1E),
        ],
        stops: [0.0323, 0.5014, 0.9652],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class LetsStartButtonBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFFF7F6C4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    // Draw left arc
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.height, size.height),
      math.pi / 2,
      math.pi,
      false,
      paint,
    );

    // Draw right arc
    canvas.drawArc(
      Rect.fromLTWH(size.width - size.height, 0, size.height, size.height),
      -math.pi / 2,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
