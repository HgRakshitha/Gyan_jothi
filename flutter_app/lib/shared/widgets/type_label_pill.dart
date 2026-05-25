import 'package:flutter/material.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/theme/text_styles.dart';

/// Pill-shaped label for activity type (Video, Book, Activity) with subtle shadow.
class TypeLabelPill extends StatelessWidget {
  final String label;

  const TypeLabelPill({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSizes.studyMaterialTypePillPadding,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius:
            BorderRadius.circular(AppSizes.studyMaterialTypePillBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: AppSizes.studyMaterialTypePillFontSize,
        ),
      ),
    );
  }
}
