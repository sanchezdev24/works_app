import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:works_app/core/theme/app_colors.dart';
import 'package:works_app/core/theme/app_text_styles.dart';

enum AppAvatarSize { xs, sm, md, lg, xl }

/// Atom: Avatar with image fallback to initials
class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final AppAvatarSize size;
  final Color? backgroundColor;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = AppAvatarSize.md,
    this.backgroundColor,
  });

  double get _dimension {
    switch (size) {
      case AppAvatarSize.xs:
        return 24;
      case AppAvatarSize.sm:
        return 36;
      case AppAvatarSize.md:
        return 48;
      case AppAvatarSize.lg:
        return 64;
      case AppAvatarSize.xl:
        return 80;
    }
  }

  double get _fontSize {
    switch (size) {
      case AppAvatarSize.xs:
        return 10;
      case AppAvatarSize.sm:
        return 13;
      case AppAvatarSize.md:
        return 16;
      case AppAvatarSize.lg:
        return 22;
      case AppAvatarSize.xl:
        return 28;
    }
  }

  String get _initials {
    if (name == null || name!.isEmpty) return '?';
    final parts = name!.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name![0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _dimension,
      height: _dimension,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_dimension),
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => _fallback,
                placeholder: (_, __) => _shimmer,
              )
            : _fallback,
      ),
    );
  }

  Widget get _fallback => Container(
        color: backgroundColor ?? AppColors.surfaceVariant,
        alignment: Alignment.center,
        child: Text(
          _initials,
          style: AppTextStyles.labelMedium.copyWith(
            fontSize: _fontSize,
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  Widget get _shimmer => Container(color: AppColors.grey200);
}
