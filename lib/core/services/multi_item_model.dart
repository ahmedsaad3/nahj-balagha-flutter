import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class MultiItem {
  final String code;
  final Map<String, String> names;
  final String? dialCode;
  final String? flag;

  MultiItem({
    required this.code,
    required this.names,
    this.dialCode,
    this.flag,
  });

  factory MultiItem.fromJson(Map<String, dynamic> json) {
    return MultiItem(
      code: json['code'],
      names: Map<String, String>.from(json['names']),
      dialCode: json['dialCode'],
      flag: json['flag'],
    );
  }
}

String labelOf(MultiItem item, String lang) {
  return item.names[lang] ??
      item.names['ar'] ??
      item.names['en'] ??
      item.names['fa'] ??
      item.names['ru'] ??
      item.names['tr'] ??
      item.names['ur'] ??
      item.names.values.first;
}

List<DropdownMenuItem<String>> fillDropdownMulti(
  BuildContext context,
  List<MultiItem> items,
) {
  final lang = Localizations.localeOf(context).languageCode;
  return items.map((item) {
    return DropdownMenuItem<String>(
      value: item.code,
      child: TextWidget(
        title: labelOf(item, lang),
        fontSize: 12,
        fontFamily: FONT_FAMILY_CAIRO,
        color: AppColorsLight.black,
      ),
    );
  }).toList();
}
