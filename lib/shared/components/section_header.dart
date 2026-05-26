import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final double? fontSize;
  final Color? titleColor;
  final Color? actionTextColor;
  final String? actionText;
  final VoidCallback? onActionTap;

  const SectionHeader({
    super.key,
    required this.title,
    this.fontSize = 12,
    this.titleColor = AppColorsLight.black,
    this.actionTextColor = AppColorsLight.accent,
    this.actionText,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          title: title,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: titleColor,
        ),
        Visibility(
          visible: onActionTap != null,
          child: InkWell(
            onTap: onActionTap,
            borderRadius: BorderRadius.circular(RADIUS),
            child: Row(
              spacing: 5,
              children: [
                TextWidget(
                  title: actionText ?? "",
                  fontSize: 12,
                  color: actionTextColor,
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColorsLight.primary,
                  size: 15,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
