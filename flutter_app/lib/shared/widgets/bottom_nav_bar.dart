import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../core/constants/app_assets.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/text_styles.dart';
import 'app_asset_image.dart';
import 'crescent_border_card.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isHomeActive = currentIndex == 0;

    return Row(
      children: [
        if (isHomeActive)
          Expanded(
            child: _HomePill(
              isActive: true,
              onTap: () => onTap(0),
            ),
          )
        else
          _HomeCircle(
            isActive: false,
            onTap: () => onTap(0),
          ),
        const SizedBox(width: 16),
        if (isHomeActive)
          _ProfileCircle(
            isActive: false,
            onTap: () => onTap(1),
          )
        else
          Expanded(
            child: _ProfilePill(
              isActive: true,
              onTap: () => onTap(1),
            ),
          ),
      ],
    );
  }
}

class _HomePill extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;

  const _HomePill({required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: CrescentBorderCard(
        height: 74,
        padding: const EdgeInsets.symmetric(horizontal: 22),
        innerColor: const Color(0xFFFBFBE4),
        borderColor: const Color(0xFFF7F6C4),
        borderWidth: 2.5,
        borderRadius: 37,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppAssetImage(
              assetPath: AppAssets.profileNavHome,
              width: 28,
              height: 28,
              fallback: Icon(
                Icons.home_outlined,
                color: AppColors.textPrimary.withValues(alpha: isActive ? 1 : 0.75),
                size: 26,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Home',
              style: AppTextStyles.titleSmall.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary
                    .withValues(alpha: isActive ? 1 : 0.75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeCircle extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;

  const _HomeCircle({required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 74,
        height: 74,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: AppAssetImage(
            assetPath: AppAssets.profileNavHome,
            width: 32,
            height: 32,
            fallback: Icon(
              Icons.home_outlined,
              color: AppColors.textPrimary.withValues(alpha: isActive ? 1 : 0.75),
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileCircle extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;

  const _ProfileCircle({required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 74,
        height: 74,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF9FDC5),
              Color(0xFFDCF62A),
            ],
            stops: [0.1, 0.7],
          ),
        ),
        child: Center(
          child: Opacity(
            opacity: isActive ? 1.0 : 0.75,
            child: const WiggleAnimation(
              child: AppAssetImage(
                assetPath: AppAssets.profileNavSmile,
                width: 32,
                height: 32,
                fallback: Icon(
                  Icons.sentiment_satisfied_alt_outlined,
                  color: AppColors.textPrimary, // Note: opacity applied by wrapper
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfilePill extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;

  const _ProfilePill({required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 74,
        padding: const EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFF6F7E4) : Colors.white,
          borderRadius: BorderRadius.circular(37),
          border: Border.all(
            color: const Color(0xFFE8E7C5),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: isActive ? 1.0 : 0.75,
              child: const WiggleAnimation(
                child: AppAssetImage(
                  assetPath: AppAssets.profileNavSmile,
                  width: 24,
                  height: 24,
                  fallback: Icon(
                    Icons.sentiment_satisfied_alt_outlined,
                    color: AppColors.textPrimary, // Note: opacity applied by wrapper
                    size: 22,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Profile',
              style: AppTextStyles.titleSmall.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary
                    .withValues(alpha: isActive ? 1 : 0.75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class WiggleAnimation extends StatefulWidget {
  final Widget child;
  const WiggleAnimation({super.key, required this.child});

  @override
  State<WiggleAnimation> createState() => _WiggleAnimationState();
}

class _WiggleAnimationState extends State<WiggleAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final angle = math.sin(_controller.value * math.pi * 2) * 0.15;
        final scale = 1.0 + (math.sin(_controller.value * math.pi) * 0.15);
        return Transform.scale(
          scale: scale,
          child: Transform.rotate(
            angle: angle,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

