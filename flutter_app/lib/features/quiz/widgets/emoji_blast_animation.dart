import 'dart:math' as math;
import 'package:flutter/material.dart';

class EmojiBlastAnimation extends StatefulWidget {
  final List<String> emojis;
  final VoidCallback? onFinished;

  const EmojiBlastAnimation({
    super.key,
    required this.emojis,
    this.onFinished,
  });

  @override
  State<EmojiBlastAnimation> createState() => _EmojiBlastAnimationState();
}

class _EmojiBlastAnimationState extends State<EmojiBlastAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  final List<_EmojiParticle> _particles = [];
  bool _initialized = false;
  bool _isFinished = false;
  double _width = 0;
  double _height = 0;

  @override
  void initState() {
    super.initState();
    // Run animation for 4 seconds
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 1.0, curve: Curves.easeOut), // fade out in last 1 second
      ),
    );
    _controller.addListener(_updatePhysics);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) {
          setState(() {
            _isFinished = true;
          });
        }
        widget.onFinished?.call();
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.removeListener(_updatePhysics);
    _controller.dispose();
    super.dispose();
  }

  void _initializeParticles() {
    if (_initialized || _width == 0 || _height == 0) return;
    _initialized = true;

    final random = math.Random();
    const count = 75; // Total particles in a single blast

    for (int i = 0; i < count; i++) {
      final emoji = widget.emojis[random.nextInt(widget.emojis.length)];
      final type = random.nextInt(10); // Determine emitter type

      if (type < 4) {
        // Bottom-left corner (shooting right-up)
        const startX = -20.0;
        final startY = _height - 20.0;
        final vx = random.nextDouble() * 11.0 + 5.0; // 5 to 16
        final vy = -(random.nextDouble() * 15.0 + 15.0); // -15 to -30
        final gravity = random.nextDouble() * 0.2 + 0.35; // gravity factor
        _particles.add(_EmojiParticle(
          emoji: emoji,
          x: startX,
          y: startY,
          vx: vx,
          vy: vy,
          rotation: random.nextDouble() * 2 * math.pi,
          rotationSpeed: random.nextDouble() * 0.16 - 0.08,
          scale: random.nextDouble() * 0.5 + 0.7, // 0.7 to 1.2
          gravity: gravity,
          isFalling: false,
        ));
      } else if (type < 8) {
        // Bottom-right corner (shooting left-up)
        final startX = _width + 20.0;
        final startY = _height - 20.0;
        final vx = -(random.nextDouble() * 11.0 + 5.0); // -5 to -16
        final vy = -(random.nextDouble() * 15.0 + 15.0); // -15 to -30
        final gravity = random.nextDouble() * 0.2 + 0.35; // gravity factor
        _particles.add(_EmojiParticle(
          emoji: emoji,
          x: startX,
          y: startY,
          vx: vx,
          vy: vy,
          rotation: random.nextDouble() * 2 * math.pi,
          rotationSpeed: random.nextDouble() * 0.16 - 0.08,
          scale: random.nextDouble() * 0.5 + 0.7, // 0.7 to 1.2
          gravity: gravity,
          isFalling: false,
        ));
      } else {
        // Top scattered (gentle drift down)
        final startX = random.nextDouble() * _width;
        const startY = -40.0;
        final vx = random.nextDouble() * 3.0 - 1.5; // -1.5 to 1.5
        final vy = random.nextDouble() * 2.5 + 1.5; // 1.5 to 4
        const gravity = 0.015;
        _particles.add(_EmojiParticle(
          emoji: emoji,
          x: startX,
          y: startY,
          vx: vx,
          vy: vy,
          rotation: random.nextDouble() * 2 * math.pi,
          rotationSpeed: random.nextDouble() * 0.06 - 0.03,
          scale: random.nextDouble() * 0.4 + 0.5, // 0.5 to 0.9
          gravity: gravity,
          isFalling: true,
        ));
      }
    }
  }

  void _updatePhysics() {
    if (!_initialized) return;
    setState(() {
      for (final p in _particles) {
        p.update(1.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isFinished) {
      return const SizedBox.shrink();
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        _width = constraints.maxWidth;
        _height = constraints.maxHeight;
        if (!_initialized && _width > 0 && _height > 0) {
          _initializeParticles();
        }

        return IgnorePointer(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: CustomPaint(
              size: Size.infinite,
              painter: _EmojiPainter(particles: _particles),
            ),
          ),
        );
      },
    );
  }
}

class _EmojiParticle {
  final String emoji;
  double x;
  double y;
  double vx;
  double vy;
  double rotation;
  final double rotationSpeed;
  final double scale;
  double opacity = 1.0;
  final double gravity;
  final bool isFalling;

  _EmojiParticle({
    required this.emoji,
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.rotation,
    required this.rotationSpeed,
    required this.scale,
    required this.gravity,
    required this.isFalling,
  });

  void update(double dt) {
    x += vx;
    y += vy;
    vy += gravity;
    rotation += rotationSpeed;

    if (isFalling) {
      // Gentle sway simulation
      vx += math.sin(y / 25.0) * 0.04;
      // Start fading as they get near the bottom half
      if (y > 350) {
        opacity = (opacity - 0.006).clamp(0.0, 1.0);
      }
    } else {
      // Fountain: start fading out when they begin falling down or near maximum height
      if (vy > -3.0) {
        opacity = (opacity - 0.012).clamp(0.0, 1.0);
      }
    }
  }
}

class _EmojiPainter extends CustomPainter {
  final List<_EmojiParticle> particles;

  _EmojiPainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      if (p.opacity <= 0.01 || p.scale <= 0.01) continue;

      // Ensure particles are within boundaries
      if (p.x < -100 || p.x > size.width + 100 || p.y > size.height + 100) continue;

      final textPainter = TextPainter(
        text: TextSpan(
          text: p.emoji,
          style: TextStyle(
            fontSize: p.scale * 28.0,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final double halfW = textPainter.width / 2;
      final double halfH = textPainter.height / 2;

      canvas.save();
      // Translate to the particle's center point
      canvas.translate(p.x, p.y);
      // Rotate the coordinate space
      canvas.rotate(p.rotation);

      final bool useLayer = p.opacity < 0.99;
      if (useLayer) {
        // Save the layer for opacity blending
        canvas.saveLayer(
          Rect.fromLTWH(-halfW - 5, -halfH - 5, textPainter.width + 10, textPainter.height + 10),
          Paint()..color = Colors.white.withValues(alpha: p.opacity),
        );
      }

      textPainter.paint(canvas, Offset(-halfW, -halfH));

      if (useLayer) {
        canvas.restore(); // Restore layer opacity
      }

      canvas.restore(); // Restore translation & rotation
    }
  }

  @override
  bool shouldRepaint(covariant _EmojiPainter oldDelegate) => true;
}
