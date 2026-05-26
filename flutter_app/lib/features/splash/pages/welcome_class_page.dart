import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../shared/widgets/quiz_header.dart';

class WelcomeClassPage extends ConsumerStatefulWidget {
  const WelcomeClassPage({super.key});

  @override
  ConsumerState<WelcomeClassPage> createState() => _WelcomeClassPageState();
}

class _WelcomeClassPageState extends ConsumerState<WelcomeClassPage> {
  int _selectedAge = 3;
  int _selectedClassIndex = 0;

  final List<int> _ages = [2, 3, 4, 5];

  final List<Map<String, String>> _classes = [
    {'name': 'Tiny Tots', 'image': 'assets/welcome/tiny_tots.png'},
    {'name': 'Playgroup A', 'image': 'assets/welcome/playgroup A.png'},
    {'name': 'Playgroup B', 'image': 'assets/welcome/playgroup B.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Yellow Wave Section
          const QuizHeader(
            title: 'Choose Class',
            showBackButton: false,
            height: 220,
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  
                  // Age Section Title
                  const Text(
                    "How Old Are You?",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  
                  // Age Section Subtitle
                  const Text(
                    "Tap your age!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Age Selector Container
                  CustomPaint(
                    painter: CurvedSideBorderPainter(),
                    child: Container(
                      width: 350,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFBFBE4),
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _ages.map((age) {
                          final isSelected = _selectedAge == age;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedAge = age;
                              });
                            },
                            child: Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFFDBF226) : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.04),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  age.toString(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 36),
                  
                  // Class Section Title
                  const Text(
                    "Choose your class",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Class Options List
                  Column(
                    children: List.generate(_classes.length, (index) {
                      final isSelected = _selectedClassIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedClassIndex = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: CustomPaint(
                            painter: CurvedSideBorderPainter(),
                            child: Container(
                              width: 350,
                              height: 80,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFBFBE4),
                                borderRadius: BorderRadius.all(Radius.circular(32)),
                              ),
                              child: Row(
                                children: [
                                  const SizedBox(width: 16),
                                  // Class Image (Avatar)
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        _classes[index]['image']!,
                                        width: 36,
                                        height: 36,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  // Class Name
                                  Expanded(
                                    child: Text(
                                      _classes[index]['name']!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  // Checkmark
                                  if (isSelected)
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.green.withValues(alpha: 0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: const Icon(
                                          Icons.check_circle_outline_rounded,
                                          color: Colors.green,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  if (!isSelected)
                                    const SizedBox(width: 52), // Balance layout if unselected
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  
                  const SizedBox(height: 36),
                  
                  // Next Button
                  GestureDetector(
                    onTap: () {
                      final selectedAge = _ages[_selectedAge == 0 ? 0 : _ages.indexOf(_selectedAge)];
                      final selectedClass = _classes[_selectedClassIndex]['name']!;
                      ref.read(userProvider.notifier).updateClassAndAge(selectedAge, selectedClass);
                      context.go(AppRoutes.welcomeAllDone);
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
// Reusable for any container size with borderRadius 32
class CurvedSideBorderPainter extends CustomPainter {
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

