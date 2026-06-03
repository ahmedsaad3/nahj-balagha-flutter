import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/content/domain/entities/scholar_explanation_entity.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class ExplanationCard extends StatelessWidget {
  final ScholarExplanationEntity explanation;
  final VoidCallback onTap;
  final bool isSelectionMode;
  final bool isSelected;

  const ExplanationCard({
    super.key,
    required this.explanation,
    required this.onTap,
    this.isSelectionMode = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RADIUS),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: IntrinsicHeight(
          child: Row(
            children: [
              if (isSelectionMode)
                Container(
                  width: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColorsLight.secondary
                        : Colors.transparent,
                  ),
                  child: Checkbox(
                    value: isSelected,
                    checkColor: AppColorsLight.textPrimary,
                    onChanged: (bool? value) {
                      onTap();
                    },
                    activeColor: AppColorsLight.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                )
              else
                // Gold vertical line indicator for normal mode
                Container(
                  width: 8,
                  decoration: BoxDecoration(
                    color: AppColorsLight.secondary,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(RADIUS),
                      bottomRight: Radius.circular(RADIUS),
                    ),
                  ),
                ),
              // Main content of the card
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        spacing: 10,
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: AppColorsLight.grayLight,
                            child: const Icon(
                              Icons.person_rounded,
                              color: AppColorsLight.gray,
                              size: 20,
                            ),
                          ),
                          Expanded(
                            child: TextWidget(
                              title: explanation.scholarName,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextWidget(
                        title: explanation.excerpt.endsWith('...')
                            ? explanation.excerpt
                            : '${explanation.excerpt} ...',
                        fontSize: 14,
                        height: 1.8,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (!isSelectionMode) ...[
                        const SizedBox(height: 10),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: TextWidget(
                            title: 'المزيد ...',
                            color: AppColorsLight.secondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
