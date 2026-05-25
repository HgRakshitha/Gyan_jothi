import 'package:flutter/material.dart';

import '../../core/theme/text_styles.dart';

/// Shown when a list filter returns no items.
class SearchEmptyState extends StatelessWidget {
  const SearchEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: Text(
          'No results match your search.',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.black54,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
