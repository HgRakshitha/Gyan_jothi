import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import '../../../shared/providers/user_provider.dart';
import '../../../shared/providers/shared_prefs_provider.dart';
import '../../../shared/widgets/quiz_header.dart';

class WelcomeAllDonePage extends ConsumerWidget {
  const WelcomeAllDonePage({super.key});

  String _getAllDoneImage(String avatarPath) {
    if (avatarPath.contains('bunny')) return 'assets/welcome/all_done_bunny.webp';
    if (avatarPath.contains('cat')) return 'assets/welcome/all_done_cat.webp';
    if (avatarPath.contains('fox')) return 'assets/welcome/all_done_fox.webp';
    if (avatarPath.contains('owl')) return 'assets/welcome/all_done_owl.webp';
    if (avatarPath.contains('monkey')) return 'assets/welcome/welcome_monkey.webp';
    if (avatarPath.contains('penguin')) return 'assets/welcome/all_done_penguin.webp';
    if (avatarPath.contains('puppy')) return 'assets/welcome/all_done_puppy.webp';
    // Fallback or bear
    return 'assets/welcome/all_done_bear.webp';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Yellow Wave Section
          const QuizHeader(
            title: 'All Done',
            showBackButton: false,
            height: 220,
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  
                  // Bear Image with Glow
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Yellow Glow
                        Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFDBF226).withValues(alpha: 0.3),
                                blurRadius: 100,
                                spreadRadius: 20,
                              ),
                            ],
                          ),
                        ),
                        // Image
                        Image.asset(
                          _getAllDoneImage(user.avatarPath),
                          width: 280,
                          height: 280,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Title
                  Text(
                    "You're All Set, ${user.name}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Start Learning Button
                  GestureDetector(
                    onTap: () {
                      // Mark onboarding as complete
                      ref.read(sharedPreferencesProvider).setBool('isFirstTime', false);
                      // Final step navigates to home!
                      context.go(AppRoutes.home);
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.auto_awesome_rounded, // Sparkles icon
                            color: Colors.black87,
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Start Learning!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
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

