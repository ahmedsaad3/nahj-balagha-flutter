import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/shared/components/app_image_widget.dart';

class CustomNavIcon extends StatelessWidget {
  final bool isActive;
  final String iconAsset;

  const CustomNavIcon({
    super.key,
    required this.isActive,
    required this.iconAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: AppImageWidget(
        imageType: ImageType.svg,
        // color: isActive ? AppColorsLight.primary : null,
        path: iconAsset,
      ),
    );
  }
}
