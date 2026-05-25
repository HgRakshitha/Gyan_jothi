import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/navigation/go_to_app_home.dart';
import '../../../../core/theme/text_styles.dart';
import '../../../../shared/widgets/quiz_header.dart';
import '../../../../shared/widgets/crescent_border_card.dart';

/// Page for the "Draw a Tree" activity with step-by-step instructions.
class DrawTreePage extends StatelessWidget {
  const DrawTreePage({super.key});

  static const Color _contentBg = Color(0xFFFBFBE4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            QuizHeader(
              title: 'Draw a Tree',
              onBack: () => goToAppHome(context),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: DrawTreePage._contentBg,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.black.withValues(alpha: 0.08), width: 1),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: const SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    padding: EdgeInsets.all(24),
                    child: _TreeStepsContent(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: _DoneButton(onPressed: () => context.pop()),
            ),
          ],
        ),
      ),
    );
  }
}

class _TreeStepsContent extends StatelessWidget {
  const _TreeStepsContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StepSection(
          stepNumber: 1,
          instruction: 'Draw two curved vertical lines down',
          child: _TreeStepIllustration(
            asset: AppAssets.learnDrawTreeStep1,
            maxWidth: _TreeStepIllustration.step1MaxWidth,
          ),
        ),
        SizedBox(height: 28),
        _StepSection(
          stepNumber: 2,
          instruction: 'Draw a big cloud-like curved shape on top',
          child: _TreeStepIllustration(asset: AppAssets.learnDrawTreeStep2),
        ),
        SizedBox(height: 28),
        _StepSection(
          stepNumber: 3,
          instruction: 'Add small curved lines inside (leaf texture)',
          child: _TreeStepIllustration(asset: AppAssets.learnDrawTreeStep3),
        ),
      ],
    );
  }
}

class _TreeStepIllustration extends StatelessWidget {
  const _TreeStepIllustration({
    required this.asset,
    this.maxWidth = defaultMaxWidth,
  });

  /// Trunk-only step: smaller so it matches “simple first step” scale (~Draw a Sun circle width).
  static const double step1MaxWidth = 140;

  /// Same width budget as [DrawHomePage] step illustrations (`_HomeDimensions.width`).
  static const double defaultMaxWidth = 200;

  final String asset;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Image.asset(
          asset,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.medium,
        ),
      ),
    );
  }
}

class _StepSection extends StatelessWidget {
  final int stepNumber;
  final String instruction;
  final Widget child;

  const _StepSection({
    required this.stepNumber,
    required this.instruction,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Step $stepNumber',
          style: AppTextStyles.bodySmall.copyWith(
            color: const Color(0xFF6B6B6B),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          instruction,
          style: AppTextStyles.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 17,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}

class _DoneButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _DoneButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: CrescentBorderCard(
        width: double.infinity,
        height: 72,
        padding: EdgeInsets.zero,
        borderWidth: 3.0,
        innerColor: const Color(0x29DBF226),
        borderGradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color.fromRGBO(225, 221, 30, 0.2),
            Color(0xFFDBF226),
            Color.fromRGBO(225, 221, 30, 0.2),
          ],
          stops: [0.0002, 0.5029, 0.9998],
        ),
        child: Center(
          child: Text(
            'Done',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
