import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/extensions/responsive_extensions.dart';
import 'package:nahj_balagha_flutter/shared/components/app_image_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/circular_progress_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

// ignore: must_be_immutable
class ElevatedButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final Color? backgroundColor;
  final double height;
  final double? width;
  final IconData? icon;
  final double iconSize;
  final String? iconAsset;
  final Color? textColor;
  final Color? iconColor;
  final ImageType imageType;
  final double fontSize;
  BorderSide? borderSide;
  final double elevation;
  final bool isLoading;
  final bool isSuccess;
  final bool isBorderSide;

  ElevatedButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.backgroundColor,
    this.height = 50,
    this.width,
    this.icon,
    this.iconSize = 20,
    this.iconAsset,
    this.textColor = AppColorsLight.white,
    this.imageType = ImageType.icon,
    this.iconColor,
    this.fontSize = 16,
    this.borderSide,
    this.elevation = 0,
    this.isLoading = false,
    this.isSuccess = false,
    this.isBorderSide = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width == 0 ? null : width ?? context.dimensions.screenWidth,
      height: height,
      child: ElevatedButton.icon(
        onPressed: onPressed == null
            ? null
            : (!isLoading && !isSuccess)
            ? onPressed
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(RADIUS),

            side: onPressed == null || isLoading || !isBorderSide
                ? BorderSide.none
                : borderSide ??
                      const BorderSide(
                        color: AppColorsLight.accent,
                        strokeAlign: 1,
                      ),
          ),
        ),
        icon: _buildLeadingIcon(),
        label: _buildButtonContent(),
      ),
    );
  }

  Widget _buildLeadingIcon() {
    // Success state takes precedence
    if (isSuccess) {
      return Icon(
        Icons.check_circle_outline,
        color: iconColor ?? Colors.green,
        size: 25,
      );
    }

    return Visibility(
      visible: _shouldShowImage() && !isLoading,
      child: AppImageWidget(
        imageType: imageType,
        icon: icon,
        path: iconAsset,
        color: iconColor,
        size: iconSize,
      ),
    );
  }

  bool _shouldShowImage() {
    switch (imageType) {
      case ImageType.svg:
      case ImageType.asset:
      case ImageType.networkSvg:
      case ImageType.network:
        return iconAsset != null;
      case ImageType.icon:
        return icon != null;
    }
  }

  Widget _buildButtonContent() {
    if (isLoading) {
      return CircularProgressWidget();
    } else {
      return TextWidget(title: title, color: textColor, fontSize: fontSize);
    }
  }
}
