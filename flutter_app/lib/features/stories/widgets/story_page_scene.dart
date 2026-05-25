import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/widgets/app_asset_image.dart';

/// Centered story illustration with fixed aspect box and [BoxFit.contain].
///
/// Opaque [AppColors.background] is drawn behind the image so transparent PNG
/// margins read as a normal full frame on the page (not a “floating” cutout).
class StoryPageScene extends StatelessWidget {
  final String assetPath;
  final double width;

  const StoryPageScene({
    super.key,
    required this.assetPath,
    required this.width,
  });

  static Widget _fallback(String path, double w, double h) {
    return Container(
      width: w,
      height: h,
      color: const Color(0xFFF0F0F0),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.broken_image_outlined, size: 48, color: Colors.grey[500]),
          const SizedBox(height: 8),
          Text(
            path,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = width * 0.78;
    return Center(
      child: SizedBox(
        width: width,
        height: h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const ColoredBox(color: AppColors.background),
            Center(
              child: AppAssetImage(
                assetPath: assetPath,
                width: width,
                height: h,
                fit: BoxFit.contain,
                fallback: _fallback(assetPath, width, h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
