import 'package:flutter/material.dart';
import 'package:works_app/core/theme/app_colors.dart';
import 'package:works_app/core/theme/app_text_styles.dart';

/// Template: Base scaffold providing consistent layout structure
class AppScaffoldTemplate extends StatelessWidget {
  final String? title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final bool showBackButton;
  final Color? backgroundColor;

  const AppScaffoldTemplate({
    super.key,
    this.title,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.appBar,
    this.showBackButton = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.background,
      appBar: appBar ??
          (title != null
              ? AppBar(
                  title: Text(title!, style: AppTextStyles.titleLarge),
                  automaticallyImplyLeading: showBackButton,
                  actions: actions,
                )
              : null),
      body: body,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
