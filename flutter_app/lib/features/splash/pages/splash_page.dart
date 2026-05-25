import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _spreadAnimation;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // Spread animation: starts at center (0.0) and spreads out (1.0) during first 1s (0% to 25%)
    _spreadAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.25, curve: Curves.easeOutCubic),
      ),
    );

    // Rotation animation: stays at 0.0 until 1s, then rotates 1 full turn (1.0) from 1s to 4s (25% to 100%)
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 1.0, curve: Curves.easeInOutCubic),
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) context.go(AppRoutes.welcome);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background base
          Container(color: Colors.white),

          // Main layout content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Stack centering the logo and its orbiting glows together
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // Animated spread and rotating yellow blobs
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final spread = _spreadAnimation.value;
                      final currentOffset = spread * 150.0; // Spreads up to 150px out from center

                      return RotationTransition(
                        turns: _rotationAnimation,
                        child: SizedBox(
                          width: 600,
                          height: 600,
                          child: Stack(
                            children: [
                              // North-West (Top-Left) shadow blob
                              Positioned(
                                // Centered at 150px when spread is 0.0, moves to 0px (top-left) when spread is 1.0
                                top: 150 - currentOffset,
                                left: 150 - currentOffset,
                                child: Container(
                                  width: 300,
                                  height: 300,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFEDF86B), // Lighter, cleaner yellow to prevent dark/muddy blur
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              // South-East (Bottom-Right) shadow blob
                              Positioned(
                                // Centered at 150px when spread is 0.0, moves to 300px (bottom-right) when spread is 1.0
                                top: 150 + currentOffset,
                                left: 150 + currentOffset,
                                child: Container(
                                  width: 300,
                                  height: 300,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFEDF86B), // Lighter, cleaner yellow to prevent dark/muddy blur
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // Backdrop filter for heavy blur effect (200px) on the orbiting glows
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 200, sigmaY: 200),
                    child: Container(
                      width: 600,
                      height: 600,
                      color: Colors.transparent,
                    ),
                  ),

                  // Direct logo centered exactly on the glows
                  Image.asset(
                    'assets/icons/home/GJ.png',
                    width: 220,
                    height: 220,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Founder Info
              const Text(
                'Founder:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Dr. Asha Rani Pal',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
