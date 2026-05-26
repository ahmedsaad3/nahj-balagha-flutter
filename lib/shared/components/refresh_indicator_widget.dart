import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';

class RefreshIndicatorWidget extends StatelessWidget {
  final Widget child;
  final RefreshCallback onRefresh;
  const RefreshIndicatorWidget({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppColorsLight.accent,
      color: AppColorsLight.white,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
