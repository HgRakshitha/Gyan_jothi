import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/theme/text_styles.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.label,
    required this.onTap,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          foregroundColor: textColor ?? AppColors.textPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(label, style: AppTextStyles.titleMedium),
      ),
    );
  }
}
