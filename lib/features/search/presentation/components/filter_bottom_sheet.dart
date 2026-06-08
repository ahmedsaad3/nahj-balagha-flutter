import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/shared/components/elevated_button_widget.dart';

class FilterBottomSheet extends StatefulWidget {
  final String initialFilter;

  const FilterBottomSheet({super.key, required this.initialFilter});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late String _selectedFilter;

  final List<Map<String, String>> _filters = [
    {'title': 'الكل (البحث الشامل)', 'value': 'الكل'},
    {'title': 'كلمة (البحث عن كلمة مطابقة)', 'value': 'كلمة'},
    {'title': 'موضوع (البحث في العناوين والموضوعات)', 'value': 'موضوع'},
    {'title': 'معنى لغة (البحث في القاموس اللغوي)', 'value': 'معنى لغة'},
    {'title': 'الاعراب (البحث في التبويب الإعرابي)', 'value': 'الاعراب'},
    {'title': 'اعلام (البحث في أسماء الشخصيات والأعلام)', 'value': 'اعلام'},
    {
      'title': 'المصطلحات البلاغية (البحث في البلاغة والبيان)',
      'value': 'المصطلحات البلاغية',
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.initialFilter;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColorsLight.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: AppColorsLight.gray.withAlpha(80),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // Sheet Title
            const Text(
              'تصفية نتائج البحث',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: FONT_FAMILY_CAIRO,
                color: AppColorsLight.primary,
              ),
            ),
            const SizedBox(height: 16),

            // Filters List
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filters.length,
                separatorBuilder: (context, index) =>
                    const Divider(height: 1, color: Color(0xFFF0F0F0)),
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = _selectedFilter == filter['value'];

                  return Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(unselectedWidgetColor: AppColorsLight.gray),
                    child: RadioListTile<String>(
                      value: filter['value']!,
                      groupValue: _selectedFilter,
                      activeColor: AppColorsLight.primary,
                      title: Text(
                        filter['title']!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontFamily: FONT_FAMILY_CAIRO,
                          color: isSelected
                              ? AppColorsLight.primary
                              : AppColorsLight.textPrimary,
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedFilter = value;
                          });
                        }
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Confirm Button
            ElevatedButtonWidget(
              onPressed: () => Navigator.pop(context, _selectedFilter),
              title: 'تطبيق الفلتر',
            ),
          ],
        ),
      ),
    );
  }
}
