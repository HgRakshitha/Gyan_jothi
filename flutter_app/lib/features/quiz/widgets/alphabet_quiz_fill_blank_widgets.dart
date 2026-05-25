import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/theme/text_styles.dart';
import '../../../shared/widgets/app_asset_image.dart';
import '../../../shared/widgets/crescent_border_card.dart';

/// Layout constants for alphabet fill-in-the-blank option tiles.
abstract final class AlphabetQuizDim {
  static const optionW = 152.0;
  static const optionH = 112.0;
  static const optionRadius = 28.0;
  static const optionSideBorder = 2.5;

  static const trueFalseW = 320.0;
  static const trueFalseH = 98.0;
}

/// Illustration with the same lime/yellow radial ground glow as the design reference.
///
/// [compact] trims padding around the asset (tighter glow footprint) so more room
/// remains for options on puzzle / tight layouts.
class AlphabetQuizIllustration extends StatelessWidget {
  final String assetPath;
  final double width;
  final double height;
  final Widget fallback;
  final bool compact;
  /// Lime/yellow glow under the asset (fine for fruit/icons; turn off for dark scenes like night sky).
  final bool showGroundGlow;

  const AlphabetQuizIllustration({
    super.key,
    required this.assetPath,
    required this.width,
    required this.height,
    required this.fallback,
    this.compact = false,
    this.showGroundGlow = true,
  });

  /// Total layout height for [compact] mode (for placing this widget outside a [FittedBox]).
  static double compactLayoutHeight(double imageHeight) => imageHeight + 21.0;

  @override
  Widget build(BuildContext context) {
    if (!showGroundGlow) {
      return _buildPlain();
    }
    if (compact) {
      return _buildCompact();
    }
    return _buildDefault();
  }

  Widget _buildPlain() {
    return AppAssetImage(
      assetPath: assetPath,
      width: width,
      height: height,
      fit: BoxFit.contain,
      fallback: fallback,
    );
  }

  Widget _buildDefault() {
    final stackH = height + 44.0;
    final stackW = math.max(280.0, width + 105.0);

    return SizedBox(
      width: stackW,
      height: stackH,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: -4,
            child: ClipOval(
              child: Container(
                width: stackW - 12,
                height: 72,
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0, -0.88),
                    radius: 1.2,
                    colors: [
                      Color.fromRGBO(230, 252, 75, 0.62),
                      Color.fromRGBO(218, 238, 48, 0.36),
                      Color.fromRGBO(200, 225, 40, 0),
                    ],
                    stops: [0.0, 0.48, 1.0],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            child: ClipOval(
              child: Container(
                width: math.min(200, width + 25),
                height: 50,
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0, -0.92),
                    radius: 1.05,
                    colors: [
                      Color.fromRGBO(236, 255, 95, 0.72),
                      Color.fromRGBO(220, 243, 44, 0.45),
                      Color.fromRGBO(210, 235, 50, 0),
                    ],
                    stops: [0.0, 0.42, 1.0],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 6,
            child: AppAssetImage(
              assetPath: assetPath,
              width: width,
              height: height,
              fit: BoxFit.contain,
              fallback: fallback,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompact() {
    final stackH = AlphabetQuizIllustration.compactLayoutHeight(height);
    final stackW = width + 28.0;

    return SizedBox(
      width: stackW,
      height: stackH,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: -4,
            child: ClipOval(
              child: Container(
                width: math.min(stackW - 4, width + 20),
                height: 52,
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0, -0.88),
                    radius: 1.15,
                    colors: [
                      Color.fromRGBO(230, 252, 75, 0.68),
                      Color.fromRGBO(218, 238, 48, 0.4),
                      Color.fromRGBO(200, 225, 40, 0),
                    ],
                    stops: [0.0, 0.48, 1.0],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 4,
            child: ClipOval(
              child: Container(
                width: math.min(width + 18, stackW - 6),
                height: 40,
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0, -0.92),
                    radius: 1.0,
                    colors: [
                      Color.fromRGBO(236, 255, 95, 0.78),
                      Color.fromRGBO(220, 243, 44, 0.48),
                      Color.fromRGBO(210, 235, 50, 0),
                    ],
                    stops: [0.0, 0.42, 1.0],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 6,
            child: AppAssetImage(
              assetPath: assetPath,
              width: width,
              height: height,
              fit: BoxFit.contain,
              fallback: fallback,
            ),
          ),
        ],
      ),
    );
  }
}

/// One answer tile ([AlphabetQuizDim.optionW]×[AlphabetQuizDim.optionH] by default).
class AlphabetQuizOptionTile extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final double? width;
  final double? height;

  const AlphabetQuizOptionTile({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor =
        selected ? AppColors.textPrimary : const Color(0xFFE8E0C8);
    final w = width ?? AlphabetQuizDim.optionW;
    final h = height ?? AlphabetQuizDim.optionH;
    final radius = (w == double.infinity || w >= 148) ? AlphabetQuizDim.optionRadius : 26.0;
    final fontSize = h < 92 ? 14.0 : 18.0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: CrescentBorderCard(
          width: w,
          height: h,
          innerColor: const Color(0xFFFBFBE4),
          borderColor: borderColor,
          borderWidth: AlphabetQuizDim.optionSideBorder,
          borderRadius: radius,
          padding: EdgeInsets.zero,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.titleMedium.copyWith(
                fontSize: fontSize,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 2×2 grid of [AlphabetQuizOptionTile]s.
class AlphabetQuizOptionGrid extends StatelessWidget {
  final List<String> labels;
  final int? selectedIndex;
  final ValueChanged<int> onSelect;

  const AlphabetQuizOptionGrid({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    const gap = 12.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: AlphabetQuizOptionTile(
                label: labels[0],
                selected: selectedIndex == 0,
                onTap: () => onSelect(0),
                width: double.infinity,
              ),
            ),
            const SizedBox(width: gap),
            Expanded(
              child: AlphabetQuizOptionTile(
                label: labels[1],
                selected: selectedIndex == 1,
                onTap: () => onSelect(1),
                width: double.infinity,
              ),
            ),
          ],
        ),
        const SizedBox(height: gap),
        Row(
          children: [
            Expanded(
              child: AlphabetQuizOptionTile(
                label: labels[2],
                selected: selectedIndex == 2,
                onTap: () => onSelect(2),
                width: double.infinity,
              ),
            ),
            const SizedBox(width: gap),
            Expanded(
              child: AlphabetQuizOptionTile(
                label: labels[3],
                selected: selectedIndex == 3,
                onTap: () => onSelect(3),
                width: double.infinity,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Stacked **True** / **False** rows — fixed 350×109, pill style, same cream palette as MCQ tiles.
class AlphabetQuizTrueFalseStack extends StatelessWidget {
  final int? selectedIndex;
  final ValueChanged<int> onSelect;

  const AlphabetQuizTrueFalseStack({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
  });

  static const _gap = 10.0;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AlphabetQuizTrueFalseTile(
            label: 'True',
            selected: selectedIndex == 0,
            onTap: () => onSelect(0),
          ),
          const SizedBox(height: _gap),
          AlphabetQuizTrueFalseTile(
            label: 'False',
            selected: selectedIndex == 1,
            onTap: () => onSelect(1),
          ),
        ],
      ),
    );
  }
}

class AlphabetQuizTrueFalseTile extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const AlphabetQuizTrueFalseTile({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  static const _radius = 28.0;

  @override
  Widget build(BuildContext context) {
    final borderColor =
        selected ? AppColors.textPrimary : const Color(0xFFE8E0C8);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(_radius),
        child: CrescentBorderCard(
          width: AlphabetQuizDim.trueFalseW,
          height: AlphabetQuizDim.trueFalseH,
          innerColor: const Color(0xFFFBFBE4),
          borderColor: borderColor,
          borderWidth: AlphabetQuizDim.optionSideBorder,
          borderRadius: _radius,
          padding: EdgeInsets.zero,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.titleMedium.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Lime gradient Submit (spec from earlier alphabet quiz screens).
class AlphabetQuizSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AlphabetQuizSubmitButton({super.key, required this.onPressed});

  static const double _fillAngleRad = 142.73 * 3.141592653589793 / 180;

  static LinearGradient _fillGradient() {
    const c1 = Color.fromRGBO(236, 255, 82, 0.74);
    const c2 = Color.fromRGBO(240, 254, 127, 0.74);
    const c3 = Color.fromRGBO(220, 243, 44, 0.74);
    return LinearGradient(
      begin: Alignment(-math.cos(_fillAngleRad), -math.sin(_fillAngleRad)),
      end: Alignment(math.cos(_fillAngleRad), math.sin(_fillAngleRad)),
      colors: const [c1, c1, c2, c3, c3],
      stops: const [0.0, 0.1333, 0.2484, 0.4654, 1.0],
    );
  }

  static const LinearGradient _borderGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color.fromRGBO(225, 221, 30, 0.2),
      Color(0xFFDBF226),
      Color.fromRGBO(225, 221, 30, 0.2),
    ],
    stops: [0.0002, 0.5029, 0.9998],
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            gradient: _borderGradient,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(996),
                gradient: _fillGradient(),
              ),
              child: Center(
                child: Text(
                  'Submit',
                  style: AppTextStyles.titleMedium.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Pale pill used beside Submit on later questions.
class AlphabetQuizBackPillButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AlphabetQuizBackPillButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          height: 54,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3D6),
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: const Color(0xFFE8E0C8),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Back',
              style: AppTextStyles.titleMedium.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Bottom row: Back (pale) + Submit (lime) — question 2+ layout.
class AlphabetQuizBackSubmitBar extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onSubmit;

  const AlphabetQuizBackSubmitBar({
    super.key,
    required this.onBack,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: AlphabetQuizBackPillButton(onPressed: onBack)),
        const SizedBox(width: 12),
        Expanded(child: AlphabetQuizSubmitButton(onPressed: onSubmit)),
      ],
    );
  }
}
