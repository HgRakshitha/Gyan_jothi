import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.child,
    this.color,
    this.borderRadius,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? AppColors.surface,
      borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.radiusMedium),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.radiusMedium),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(AppSizes.paddingCard),
          child: child,
        ),
      ),
    );
  }
}
