import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_assets.dart';
import '../../core/theme/text_styles.dart';

class AppSearchBar extends StatelessWidget {
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onMicTap;
  final Color? backgroundColor;
  final Color? borderColor;

  const AppSearchBar({
    super.key,
    required this.hint,
    this.onChanged,
    this.onMicTap,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: borderColor ?? const Color(0xFFF7F6C4),
        borderRadius: BorderRadius.circular(36.5),
      ),
      child: Container(
        height: 66,
        decoration: BoxDecoration(
          color: backgroundColor ?? const Color(0xFFFBFBE4),
          borderRadius: BorderRadius.circular(34),
        ),
        child: Row(
        children: [
          const SizedBox(width: 18),
          SvgPicture.asset(
            AppAssets.iconSearch,
            width: 28,
            height: 28,
            colorFilter:
                const ColorFilter.mode(AppColors.textPrimary, BlendMode.srcIn),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textHint,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
              ),
            ),
          ),
          GestureDetector(
            onTap: onMicTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: SvgPicture.asset(
                AppAssets.iconMic,
                width: 28,
                height: 28,
                colorFilter: const ColorFilter.mode(
                  AppColors.textPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      ),
    );
  }
}

