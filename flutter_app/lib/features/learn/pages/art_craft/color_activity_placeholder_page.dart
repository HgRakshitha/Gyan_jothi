import 'package:flutter/material.dart';

import '../../../../core/navigation/go_to_app_home.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../shared/widgets/quiz_header.dart';

/// Placeholder until a full coloring canvas is added for each activity.
class ColorActivityPlaceholderPage extends StatelessWidget {
  const ColorActivityPlaceholderPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBE4),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QuizHeader(
              title: title,
              onBack: () => goToAppHome(context),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Coloring activity coming soon.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodyMedium
                        .copyWith(color: Colors.black54),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
