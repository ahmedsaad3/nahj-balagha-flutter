import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class ChipWidget extends StatelessWidget {
  final String label;
  final bool isLast;
  final VoidCallback? onTap;
  const ChipWidget({
    super.key,
    required this.label,
    this.isLast = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(RADIUS),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isLast
              ? AppColorsLight.accent.withAlpha(20)
              : AppColorsLight.gray.withAlpha(15),
          borderRadius: BorderRadius.circular(RADIUS),
        ),
        child: TextWidget(
          title: label,
          fontSize: 14,
          color: isLast
              ? AppColorsLight.accent
              : AppColorsLight.textPrimary.withAlpha(180),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
