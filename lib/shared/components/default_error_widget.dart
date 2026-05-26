import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class DefaultErrorWidget extends StatelessWidget {
  final String message;
  const DefaultErrorWidget({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: AppColorsLight.red,
            ),
            TextWidget(
              title: message,
              alignment: TextAlign.center,
              color: AppColorsLight.red,
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }
}
