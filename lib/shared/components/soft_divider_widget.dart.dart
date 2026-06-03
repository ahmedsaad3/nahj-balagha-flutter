import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/extensions/responsive_extensions.dart';

class SoftDividerWidget extends StatelessWidget {
  final Axis axis;
  final double? length;
  final double thickness;
  final double intensity;
  final Color color;
  final double radius;
  final bool enableGradient;
  final EdgeInsets? margin;

  const SoftDividerWidget({
    super.key,
    this.axis = Axis.horizontal,
    this.length,
    this.thickness = 1,
    this.intensity = 0.3,
    this.color = AppColorsLight.textPrimary,
    this.radius = 999,
    this.enableGradient = true,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final isVertical = axis == Axis.vertical;
    final w = isVertical ? thickness : length ?? context.dimensions.screenWidth;
    final h = isVertical ? length ?? context.dimensions.screenWidth : thickness;

    final gradient = LinearGradient(
      begin: isVertical ? Alignment.centerLeft : Alignment.topCenter,
      end: isVertical ? Alignment.centerRight : Alignment.bottomCenter,
      colors: [
        color.withOpacity(intensity),
        color.withOpacity(intensity * 0.55),
      ],
    );

    return Container(
      width: w,
      height: h,
      padding: EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: enableGradient ? gradient : null,
        color: color,
      ),
    );
  }
}
