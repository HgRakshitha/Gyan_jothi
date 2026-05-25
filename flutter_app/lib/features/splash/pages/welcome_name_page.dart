import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../shared/widgets/quiz_header.dart';

class WelcomeNamePage extends ConsumerStatefulWidget {
  const WelcomeNamePage({super.key});

  @override
  ConsumerState<WelcomeNamePage> createState() => _WelcomeNamePageState();
}

class _WelcomeNamePageState extends ConsumerState<WelcomeNamePage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Yellow Wave Section (as used in quiz)
          const QuizHeader(
            title: 'Your Name',
            showBackButton: false,
            height: 220,
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  
                  // Title
                  const Text(
                    "What's Your Name?",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Subtitle
                  const Text(
                    "Type your name so we know who you are!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 48),
                  
                  // Name Input Tab
                  CustomPaint(
                    painter: NameInputBorderPainter(),
                    child: Container(
                      width: 350,
                      height: 121,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFBFBE4),
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      alignment: Alignment.center,
                      child: TextField(
                        controller: _nameController,
                        textAlign: TextAlign.center,
                        cursorColor: Colors.black, // Makes cursor blend in, no weird colors
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Your Name',
                          hintStyle: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                          // Override global theme filled background
                          filled: false,
                          fillColor: Colors.transparent,
                          // Completely remove all possible borders from the text field itself
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 24),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Next Button
                  GestureDetector(
                    onTap: () {
                      final name = _nameController.text.trim();
                      if (name.isNotEmpty) {
                        ref.read(userProvider.notifier).updateName(name);
                      }
                      context.go(AppRoutes.welcomeBuddy);
                    },
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
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for Left/Right solid borders on a rounded rectangle
class NameInputBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFFF7F6C4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    const double radius = 32.0;

    // Left border (covers left straight edge, and both left curves)
    final pathLeft = Path()
      ..moveTo(radius, 0)
      ..arcToPoint(const Offset(0, radius), radius: const Radius.circular(radius), clockwise: false)
      ..lineTo(0, size.height - radius)
      ..arcToPoint(Offset(radius, size.height), radius: const Radius.circular(radius), clockwise: false);
    
    // Right border (covers right straight edge, and both right curves)
    final pathRight = Path()
      ..moveTo(size.width - radius, 0)
      ..arcToPoint(Offset(size.width, radius), radius: const Radius.circular(radius), clockwise: true)
      ..lineTo(size.width, size.height - radius)
      ..arcToPoint(Offset(size.width - radius, size.height), radius: const Radius.circular(radius), clockwise: true);

    canvas.drawPath(pathLeft, paint);
    canvas.drawPath(pathRight, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
