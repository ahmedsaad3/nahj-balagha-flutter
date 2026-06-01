import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/browse/domain/entities/browse_node.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class CategoryWidget extends StatelessWidget {
  final BrowseNode node;
  final BrowseNode parent;

  const CategoryWidget({super.key, required this.node, required this.parent});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.categoryScreen,
          arguments: [parent, node],
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(RADIUS2),
          border: Border.all(color: AppColorsLight.gray, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextWidget(
              title: node.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColorsLight.buttonPrimary,
            ),
            if (node.count != null) ...[
              const SizedBox(width: 6),
              TextWidget(
                title: node.count!,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppColorsLight.gray,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
