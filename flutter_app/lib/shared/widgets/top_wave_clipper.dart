import 'package:flutter/material.dart';

class TopWaveClipper extends CustomClipper<Path> {
  const TopWaveClipper();

  @override
  Path getClip(Size size) {
    final path = Path();
    const double radius = 66.0;
    const double dipDepth = 12.0;

    path.moveTo(0, radius);
    path.quadraticBezierTo(0, 0, radius + 10, 0);
    path.lineTo(size.width * 0.10, 0);
    path.cubicTo(
      size.width * 0.20,
      0,
      size.width * 0.30,
      dipDepth * 0.06,
      size.width * 0.40,
      dipDepth * 0.50,
    );
    path.cubicTo(
      size.width * 0.45,
      dipDepth * 0.82,
      size.width * 0.50,
      dipDepth,
      size.width * 0.55,
      dipDepth * 0.82,
    );
    path.cubicTo(
      size.width * 0.70,
      dipDepth * 0.06,
      size.width * 0.80,
      0,
      size.width * 0.90,
      0,
    );
    path.lineTo(size.width - radius - 10, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
