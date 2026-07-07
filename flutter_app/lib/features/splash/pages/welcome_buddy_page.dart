import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../shared/widgets/quiz_header.dart';

class WelcomeBuddyPage extends ConsumerStatefulWidget {
  const WelcomeBuddyPage({super.key});

  @override
  ConsumerState<WelcomeBuddyPage> createState() => _WelcomeBuddyPageState();
}

class _WelcomeBuddyPageState extends ConsumerState<WelcomeBuddyPage> {
  int _selectedBuddyIndex = 0;

  final List<Map<String, String>> buddies = [
    {'name': 'Bear', 'image': 'assets/avatar/bear.webp'},
    {'name': 'Cat', 'image': 'assets/avatar/cat.webp'},
    {'name': 'Bunny', 'image': 'assets/avatar/bunny.webp'},
    {'name': 'Fox', 'image': 'assets/avatar/fox.webp'},
    {'name': 'Panda', 'image': 'assets/avatar/panda.webp'},
    {'name': 'Puppy', 'image': 'assets/avatar/puppy.webp'},
    {'name': 'Monkey', 'image': 'assets/avatar/monkey.webp'},
    {'name': 'Owl', 'image': 'assets/avatar/owl.webp'},
    {'name': 'Penguin', 'image': 'assets/avatar/penguin.webp'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Yellow Wave Section
          const QuizHeader(
            title: 'Pick a Buddy',
            showBackButton: false,
            height: 220,
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  
                  // Title
                  const Text(
                    "Pick Your Buddy!",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Subtitle
                  const Text(
                    "Choose a friend to learn with you",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Grid Container
                  CustomPaint(
                    painter: BuddyBorderPainter(),
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFBFBE4),
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      alignment: Alignment.center,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.center,
                        children: List.generate(buddies.length, (index) {
                          final isSelected = _selectedBuddyIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedBuddyIndex = index;
                              });
                            },
                            child: SizedBox(
                              width: 115,
                              height: 120,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  // White Card
                                  Container(
                                    width: 115,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(24),
                                      border: isSelected
                                          ? Border.all(color: Colors.green.withValues(alpha: 0.5), width: 1.5)
                                          : null,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.05),
                                          blurRadius: 25,
                                          spreadRadius: 8,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Image.asset(
                                              buddies[index]['image']!,
                                              width: 75,
                                              height: 75,
                                              fit: BoxFit.contain,
                                              filterQuality: FilterQuality.high,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          buddies[index]['name']!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                  
                                  // Green Checkmark
                                  if (isSelected)
                                    Positioned(
                                      top: -2,
                                      right: -2,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.check_circle_outline_rounded,
                                          color: Colors.green,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Next Button
                  GestureDetector(
                    onTap: () {
                      final selectedBuddy = buddies[_selectedBuddyIndex]['image']!;
                      ref.read(userProvider.notifier).updateAvatar(selectedBuddy);
                      context.go(AppRoutes.welcomeClass);
                    },
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 32),
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
class BuddyBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFFF7F6C4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    const double radius = 32.0;

    final pathLeft = Path()
      ..moveTo(radius, 0)
      ..arcToPoint(const Offset(0, radius), radius: const Radius.circular(radius), clockwise: false)
      ..lineTo(0, size.height - radius)
      ..arcToPoint(Offset(radius, size.height), radius: const Radius.circular(radius), clockwise: false);
    
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

