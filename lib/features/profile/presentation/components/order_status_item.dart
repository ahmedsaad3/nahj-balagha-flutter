import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class OrderStatusItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final int? count;
  final VoidCallback? onTap;

  const OrderStatusItem({
    super.key,
    required this.title,
    required this.imagePath,
    this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(width: 100, height: 100, child: Image.asset(imagePath)),
              if (count != null)
                Positioned(
                  top: -6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    margin: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: AppColorsLight.accent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextWidget(
                      title: '$count',
                      fontSize: 10,
                      color: AppColorsLight.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),

          TextWidget(
            title: title,
            alignment: TextAlign.center,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}
