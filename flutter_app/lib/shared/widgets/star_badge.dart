import 'package:flutter/material.dart';

import '../../core/constants/app_assets.dart';
import 'app_asset_image.dart';

/// Star badge (huggy) with yellow glow/shine effect.
class StarBadge extends StatelessWidget {
  final double size;

  const StarBadge({super.key, this.size = 80});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withValues(alpha: 0.18),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: AppAssetImage(
        assetPath: AppAssets.englishHuggy,
        width: size,
        height: size,
        fallback: Icon(
          Icons.star_rounded,
          size: size * 0.8,
          color: Colors.amber,
        ),
      ),
    );
  }
}
