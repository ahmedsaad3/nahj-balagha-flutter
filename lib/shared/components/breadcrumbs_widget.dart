import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/browse/domain/entities/browse_node.dart';
import 'package:nahj_balagha_flutter/shared/components/chip_widget.dart';

class BreadcrumbsWidget extends StatelessWidget {
  final List<BrowseNode> trail;
  const BreadcrumbsWidget({super.key, required this.trail});

  @override
  Widget build(BuildContext context) {
    if (trail.isEmpty) return const SizedBox.shrink();

    return Container(
      alignment: Alignment.centerRight,
      color: AppColorsLight.grayLight.withAlpha(40),
      padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL, vertical: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(trail.length, (index) {
            final node = trail[index];
            final isLast = index == trail.length - 1;

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ChipWidget(
                  label: node.title,
                  isLast: isLast,
                  onTap: () {
                    if (isLast) return;
                    final popCount = trail.length - 1 - index;
                    for (int i = 0; i < popCount; i++) {
                      Navigator.pop(context);
                    }
                  },
                ),
                if (!isLast) ...[
                  const SizedBox(width: 8),
                  Icon(
                    Icons.chevron_right_rounded,
                    size: 14,
                    color: AppColorsLight.gray.withAlpha(150),
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            );
          }),
        ),
      ),
    );
  }
}
