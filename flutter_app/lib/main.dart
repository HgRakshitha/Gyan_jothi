import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_strings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: GyanJyotiApp()));
}

class GyanJyotiApp extends StatelessWidget {
  const GyanJyotiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        final isWeb = mediaQuery.size.width > 600;
        final width = isWeb ? 450.0 : mediaQuery.size.width;

        return Container(
          color: const Color(0xFFE5E5E5), // Subtle grey background for desktop
          child: Center(
            child: SizedBox(
              width: width,
              child: ClipRect(
                child: MediaQuery(
                  // Override media query so inner screens think they are 450px wide
                  data: mediaQuery.copyWith(
                    size: Size(width, mediaQuery.size.height),
                  ),
                  child: child!,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
