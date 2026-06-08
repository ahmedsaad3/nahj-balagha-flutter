import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class ContentSnippetWidget extends StatelessWidget {
  final String title;
  final String? description;
  final Widget? descriptionWidget;
  final VoidCallback onTap;

  const ContentSnippetWidget({
    super.key,
    required this.title,
    this.description,
    this.descriptionWidget,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColorsLight.gray.withAlpha(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 10,
          children: [
            TextWidget(
              title: title,
              fontSize: 14,
              color: AppColorsLight.accent,
              fontWeight: FontWeight.bold,
            ),
            if (descriptionWidget != null)
              descriptionWidget!
            else if (description != null)
              TextWidget(title: description!, fontSize: 13, height: 1.8),
          ],
        ),
      ),
    );
  }
}
