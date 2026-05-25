import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AppProgressBar extends StatelessWidget {
  final double value; // 0.0 to 1.0
  final Color? color;
  final double height;

  const AppProgressBar({
    super.key,
    required this.value,
    this.color,
    this.height = 8,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: LinearProgressIndicator(
        value: value,
        minHeight: height,
        backgroundColor: AppColors.divider,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? AppColors.primary),
      ),
    );
  }
}
