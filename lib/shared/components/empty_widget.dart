import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class EmptyWidget extends StatelessWidget {
  final String title;
  final String? message;
  final IconData? icon;
  const EmptyWidget({super.key, required this.title, this.message, this.icon});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 70,
              color: AppColorsLight.primary,
            ),
            TextWidget(
              title: title,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColorsLight.primary,
            ),
            if (message != null) ...[
              TextWidget(
                title: message!,
                alignment: TextAlign.center,
                fontSize: 13,
                height: 1.5,
                color: AppColorsLight.gray,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
