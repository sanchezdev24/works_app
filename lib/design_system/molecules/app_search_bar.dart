import 'package:flutter/material.dart';
import 'package:works_app/core/theme/app_colors.dart';
import 'package:works_app/core/theme/app_spacing.dart';
import 'package:works_app/core/theme/app_text_styles.dart';

/// Molecule: Search bar combining TextFormField atoms
class AppSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterTap;

  const AppSearchBar({
    super.key,
    this.controller,
    this.hint = 'Search jobs...',
    this.onChanged,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.radiusMD,
        border: Border.all(color: AppColors.grey200),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(Icons.search_rounded, color: AppColors.grey500),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTextStyles.bodyMedium,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: AppTextStyles.bodyMedium
                    .copyWith(color: AppColors.textDisabled),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          if (onFilterTap != null)
            GestureDetector(
              onTap: onFilterTap,
              child: Container(
                margin: const EdgeInsets.all(6),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: AppRadius.radiusSM,
                ),
                child: const Icon(
                  Icons.tune_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
