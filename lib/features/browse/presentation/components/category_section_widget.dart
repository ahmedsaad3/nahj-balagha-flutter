import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/browse/domain/entities/browse_node.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';
import 'category_widget.dart';

class CategorySectionWidget extends StatelessWidget {
  final BrowseNode category;

  const CategorySectionWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final hasChips = category.children.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: HORIZONTAL,
            vertical: 14,
          ),
          decoration: BoxDecoration(color: AppColorsLight.gray.withAlpha(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                title: category.title,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColorsLight.textPrimary,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.categoryScreen,
                    arguments: [category],
                  );
                },
                borderRadius: BorderRadius.circular(5),
                child: TextWidget(
                  title: 'الكل',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColorsLight.accent,
                ),
              ),
            ],
          ),
        ),
        if (hasChips) ...[
          Padding(
            padding: const EdgeInsets.only(
              left: HORIZONTAL,
              right: HORIZONTAL,
              top: 16,
              bottom: 0,
            ),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: category.children.take(9).map((childNode) {
                return CategoryWidget(node: childNode, parent: category);
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }
}
