import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/shared/components/app_image_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String asset;
  final Widget? trailing;
  final bool isActiveTrailing;
  final Color? color;
  final Color? iconColor;
  final double? leadingIconSize;
  final VoidCallback? onTap;
  final double? fontSize;

  const CustomListTile({
    super.key,
    required this.title,
    required this.asset,
    this.trailing,
    this.color = AppColorsLight.primary,
    this.iconColor = AppColorsLight.accent,
    this.leadingIconSize = 20,
    this.onTap,
    this.fontSize = 14,
    this.isActiveTrailing = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        title: TextWidget(
          title: title,
          fontSize: fontSize,
          color: color,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing:
            trailing ??
            Visibility(
              visible: isActiveTrailing,
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColorsLight.black,
                size: 20,
              ),
            ),
        contentPadding: EdgeInsets.zero,
        leading: AppImageWidget(
          path: asset,
          color: iconColor,
          imageType: ImageType.svg,
        ),
      ),
    );
  }
}
