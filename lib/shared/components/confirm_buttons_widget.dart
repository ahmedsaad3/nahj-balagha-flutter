import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/shared/components/elevated_button_widget.dart';

class ConfirmButtonsWidget extends StatelessWidget {
  final VoidCallback onYes;
  final VoidCallback? onNo;

  const ConfirmButtonsWidget({super.key, required this.onYes, this.onNo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 14,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ElevatedButtonWidget(
              onPressed: onYes,
              title: "نعم",
            ),
          ),
          Expanded(
            child: ElevatedButtonWidget(
              onPressed: onNo ?? () => Navigator.pop(context),
              title: "لا",
              textColor: AppColorsLight.white,
              backgroundColor: AppColorsLight.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
