import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/typedef.dart';
import 'package:nahj_balagha_flutter/extensions/responsive_extensions.dart';
import 'package:nahj_balagha_flutter/shared/components/app_image_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class InputFieldWidget extends StatelessWidget {
  final String? title;
  final String hintText;
  final bool enableShowPassword;
  final int maxLines;
  final double spacing;
  final ValidCallBack? valid;
  final ValidCallBack? onChanged;
  final TextInputType textInputType;
  final VoidCallback? onTap;
  final double? width;
  final bool readOnly;
  final bool enabled;
  final bool showPassword;
  final FocusNode? focusNode;
  final VoidCallback? onFieldSubmitted;
  final VoidCallback? onPressedShowPassword;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final TextAlign? textAlign;
  final bool autofocus;
  final int? maxLength;
  final ImageType imageType;
  final IconData? icon;
  final String? iconAsset;
  final InputBorder? focusedBorder;
  final Widget? suffixIcon;
  final Color? fillColor;
  final TextStyle? hintStyle;

  const InputFieldWidget({
    super.key,
    this.title,
    required this.hintText,
    this.enableShowPassword = false,
    this.maxLines = 1,
    this.spacing = 5,
    this.valid,
    this.onChanged,
    required this.textInputType,
    this.controller,
    this.width,
    this.focusNode,
    this.onTap,
    this.readOnly = false,
    this.enabled = true,
    this.onFieldSubmitted,
    this.onPressedShowPassword,
    this.showPassword = false,
    this.textInputAction,
    this.textAlign,
    this.autofocus = false,
    this.maxLength,
    this.imageType = ImageType.icon,
    this.icon,
    this.iconAsset,
    this.focusedBorder,
    this.suffixIcon,
    this.fillColor,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.dimensions.screenWidth,
      child: Column(
        spacing: spacing,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          title == null
              ? const SizedBox.shrink()
              : TextWidget(
                  title: title ?? "",
                  fontSize: 12,
                  color: AppColorsLight.primary,
                  fontWeight: FontWeight.w400,
                ),
          SizedBox(
            child: TextFormField(
              maxLength: maxLength,
              cursorColor: AppColorsLight.accent,
              onTap: onTap,
              textInputAction: textInputAction,
              onFieldSubmitted: (_) => onFieldSubmitted?.call(),
              focusNode: focusNode,
              controller: controller,
              enabled: enabled,
              obscureText: showPassword,
              readOnly: readOnly,
              autofocus: autofocus,
              validator: valid,
              onChanged: onChanged,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: textInputType,
              maxLines: maxLines,
              textAlign: textAlign ?? TextAlign.start,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: FONT_FAMILY_CAIRO,
                color: AppColorsLight.black,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: hintStyle,

                suffixIcon: enableShowPassword
                    ? IconButton(
                        icon: Icon(
                          showPassword
                              ? Icons.visibility_off_outlined
                              : Icons.remove_red_eye_outlined,
                          size: 25,
                          color: AppColorsLight.gray,
                        ),
                        onPressed: onPressedShowPassword,
                      )
                    : suffixIcon,

                focusedBorder: focusedBorder,
                border: focusedBorder,
                enabledBorder: focusedBorder,
                fillColor: fillColor,

                prefixIcon: iconAsset != null || icon != null
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AppImageWidget(
                          path: iconAsset,
                          imageType: imageType,
                          color: AppColorsLight.accent,
                          scale: 0.7,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
