import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/theme/text_styles.dart';
import '../../../shared/widgets/app_asset_image.dart';

/// Model for a Quick Access card
class QuickAccessData {
  final String label;
  final Color backgroundColor;
  final String? imagePath; // null until image asset provided
  final double imageScale;
  final double imageRight;
  final double imageBottom;

  const QuickAccessData({
    required this.label,
    required this.backgroundColor,
    this.imagePath,
    this.imageScale = 0.94,
    this.imageRight = -6,
    this.imageBottom = -8,
  });
}

class QuickAccessCard extends StatelessWidget {
  static const double _cardRadius = 28.0;
  final QuickAccessData data;
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Border? border;

  const QuickAccessCard({
    super.key,
    required this.data,
    this.onTap,
    this.height,
    this.width,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? _cardRadius;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height ?? AppSizes.quickAccessCardHeight,
        decoration: BoxDecoration(
          color: data.backgroundColor,
          borderRadius: BorderRadius.circular(radius),
          border: border,
        ),
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [
            // Label top-left
            Positioned(
              top: 18,
              left: 18,
              child: Text(
                data.label,
                style: AppTextStyles.titleMedium.copyWith(
                  fontFamily: 'Mona Sans',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  height: 1.0,
                  letterSpacing: 0,
                ),
              ),
            ),
            // Illustration (SVG or image) bottom-right
            if (data.imagePath != null)
              Positioned(
                bottom: data.imageBottom,
                right: data.imageRight,
                child: AppAssetImage(
                  assetPath: data.imagePath!,
                  height:
                      (height ?? AppSizes.quickAccessCardHeight) * data.imageScale,
                  fit: BoxFit.contain,
                  fallback: _IllustrationPlaceholder(label: data.label),
                ),
              )
            else
              // Placeholder shape while image not yet added
              Positioned(
                bottom: 6,
                right: 10,
                child: _IllustrationPlaceholder(label: data.label),
              ),
          ],
        ),
      ),
    );
  }
}

class _IllustrationPlaceholder extends StatelessWidget {
  final String label;
  const _IllustrationPlaceholder({required this.label});

  static const Map<String, IconData> _icons = {
    'Learn': Icons.menu_book_rounded,
    'Quiz': Icons.quiz_rounded,
    'Events': Icons.emoji_events_rounded,
    'Stories': Icons.auto_stories_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return Icon(
      _icons[label] ?? Icons.star_rounded,
      size: 52,
      color: Colors.black.withValues(alpha: 0.12),
    );
  }
}
