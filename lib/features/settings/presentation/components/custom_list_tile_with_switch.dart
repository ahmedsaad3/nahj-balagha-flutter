import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/typedef.dart';
import 'package:nahj_balagha_flutter/shared/components/app_image_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class CustomListTileWithSwitch extends StatelessWidget {
  final String title;
  final String asset;
  final ValidCallbackBoolean onChanged;
  final bool isSwitchOn;
  final Widget? trailing;
  final Color? color;

  const CustomListTileWithSwitch({
    super.key,
    required this.title,
    required this.asset,
    this.onChanged,
    this.isSwitchOn = true,
    this.color,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: TextWidget(title: title, fontSize: 14, color: color),
          trailing: trailing ?? Switch(value: isSwitchOn, onChanged: onChanged),
          contentPadding: EdgeInsets.zero,
          leading: AppImageWidget(
            imageType: ImageType.svg,
            path: asset,
            color: AppColorsLight.accent,
            size: 20,
          ),
          onTap: null,
        ),
      ],
    );
  }
}
