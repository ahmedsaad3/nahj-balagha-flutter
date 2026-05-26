import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/extensions/responsive_extensions.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final double? fontSize;
  final double? height;
  final TextAlign alignment;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final String? fontFamily;
  final TextTheme? textStyle;
  final TextDirection? textDirection;
  final bool underline;
  final bool softWrap;

  const TextWidget({
    super.key,
    required this.title,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.alignment = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.height,
    this.fontFamily = FONT_FAMILY_CAIRO,
    // this.fontFamily = FONT_FAMILY_CAIRO,
    this.textStyle,
    this.textDirection,
    this.underline = false,
    this.softWrap = true,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: alignment,
      overflow: overflow,
      textScaleFactor: context.dimensions.textScaleFactor(),
      textDirection: textDirection,
      maxLines: maxLines,
      softWrap: softWrap,
      style: TextStyle(
        height: height,
        fontWeight: fontWeight,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
        decorationColor: color,
        decorationThickness: underline ? 2 : null,
        fontFamily: fontFamily,
        // fontFamily: UiUtils.getFontFamily(
        //   context: context,
        //   fontFamily: fontFamily,
        // ),
        // color: Theme.of(context).textTheme.titleSmall,
        // color: context.titleSmall,
        color: color,
        fontSize: fontSize,
        overflow: overflow,
      ),
    );
  }
}
