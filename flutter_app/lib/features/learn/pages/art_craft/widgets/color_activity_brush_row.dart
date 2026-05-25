import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/theme/text_styles.dart';

/// Default stroke widths for color-activity canvases (logical pixels).
const List<double> kColorActivityBrushStrokeWidths = <double>[8, 14, 22];

/// Small / Medium / Large brush picker used on tree, animal, home, and balloon pages.
class ColorActivityBrushSizeRow extends StatelessWidget {
  const ColorActivityBrushSizeRow({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
    this.widths = kColorActivityBrushStrokeWidths,
  });

  final List<double> widths;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  static const List<String> _labels = <String>['Small', 'Medium', 'Large'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Brush size',
          style: AppTextStyles.labelSmall.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < widths.length; i++) ...[
              if (i > 0) const SizedBox(width: 14),
              ColorActivityBrushSizeChip(
                strokeWidth: widths[i],
                label: _labels[i],
                selected: selectedIndex == i,
                onTap: () => onSelect(i),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class ColorActivityBrushSizeChip extends StatelessWidget {
  const ColorActivityBrushSizeChip({
    super.key,
    required this.strokeWidth,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final double strokeWidth;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  static const double _box = 40;

  @override
  Widget build(BuildContext context) {
    final dotR = (strokeWidth * 0.5).clamp(3.0, 12.0);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: _box,
              height: _box,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selected ? AppColors.textPrimary : Colors.black26,
                  width: selected ? 2.2 : 1.1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Container(
                width: dotR * 2,
                height: dotR * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.textPrimary.withValues(alpha: 0.75),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                color: selected ? AppColors.textPrimary : AppColors.textSecondary,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
