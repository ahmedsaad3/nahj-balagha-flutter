import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class CategoryTabs extends StatelessWidget {
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;
  final Map<String, int> categoryCounts;

  const CategoryTabs({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.categoryCounts,
  });

  static const List<String> _categories = [
    'الكل',
    'الكتب',
    'الخطب',
    'الرسائل',
    'الإعراب',
    'المفردات',
    'صوتيات',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = selectedCategory == category;
          final count = categoryCounts[category] ?? 0;
          
          // Display count next to tab label for context, except for "الكل" or if count is 0
          final label = (category == 'الكل' || count == 0)
              ? category
              : '$category ($count)';

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: () => onCategorySelected(category),
              borderRadius: BorderRadius.circular(20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF1F8C64)
                      : AppColorsLight.gray.withAlpha(20),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF1F8C64)
                        : Colors.transparent,
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: TextWidget(
                  title: label,
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected
                      ? AppColorsLight.white
                      : AppColorsLight.textPrimary.withAlpha(220),
                  fontFamily: FONT_FAMILY_CAIRO,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
