import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';

class SearchTextHighlight extends StatelessWidget {
  final String text;
  final String query;
  final Color? highlightColor;
  final TextStyle? textStyle;
  final int? maxLines;
  final TextOverflow overflow;

  const SearchTextHighlight({
    super.key,
    required this.text,
    required this.query,
    this.highlightColor,
    this.textStyle,
    this.maxLines,
    this.overflow = TextOverflow.clip,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultStyle = textStyle ??
        const TextStyle(
          fontSize: 14,
          fontFamily: FONT_FAMILY_CAIRO,
          color: AppColorsLight.textPrimary,
        );

    final Color colorOfHighlight =
        highlightColor ?? AppColorsLight.secondary.withAlpha(80);

    if (query.trim().isEmpty) {
      return Text(
        text,
        style: defaultStyle,
        textDirection: TextDirection.rtl,
        maxLines: maxLines,
        overflow: maxLines != null ? overflow : TextOverflow.clip,
      );
    }

    // Build the Arabic diacritic-insensitive RegExp
    final RegExp regex = _buildArabicSearchRegExp(query.trim());

    if (regex.pattern.isEmpty) {
      return Text(
        text,
        style: defaultStyle,
        textDirection: TextDirection.rtl,
        maxLines: maxLines,
        overflow: maxLines != null ? overflow : TextOverflow.clip,
      );
    }

    final List<TextSpan> spans = [];
    int lastIndex = 0;

    final matches = regex.allMatches(text);

    for (final match in matches) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(
          text: text.substring(lastIndex, match.start),
          style: defaultStyle,
        ));
      }

      spans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: defaultStyle.copyWith(
          backgroundColor: colorOfHighlight,
          fontWeight: FontWeight.bold,
        ),
      ));

      lastIndex = match.end;
    }

    if (lastIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastIndex),
        style: defaultStyle,
      ));
    }

    return RichText(
      text: TextSpan(
        children: spans,
        style: defaultStyle,
      ),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.justify,
      maxLines: maxLines,
      overflow: maxLines != null ? overflow : TextOverflow.clip,
    );
  }

  RegExp _buildArabicSearchRegExp(String query) {
    final diacriticsPattern = r'[\u064B-\u0652\u0670]*';
    final buffer = StringBuffer();

    for (int i = 0; i < query.length; i++) {
      final char = query[i];

      // Handle Arabic variants
      if (char == 'أ' || char == 'إ' || char == 'آ' || char == 'ا') {
        buffer.write('[أإآا]');
      } else if (char == 'ة' || char == 'ه') {
        buffer.write('[ةه]');
      } else if (char == 'ى' || char == 'ي') {
        buffer.write('[ىي]');
      } else {
        // Escape special regex characters
        buffer.write(RegExp.escape(char));
      }

      if (i < query.length - 1) {
        buffer.write(diacriticsPattern);
      }
    }
    buffer.write(diacriticsPattern);

    try {
      return RegExp(buffer.toString(), caseSensitive: false);
    } catch (_) {
      return RegExp('');
    }
  }
}
