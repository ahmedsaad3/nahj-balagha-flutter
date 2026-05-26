import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/services/dropdown_info_multi.dart';
import 'package:nahj_balagha_flutter/core/services/multi_item_model.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/typedef.dart';
import 'package:nahj_balagha_flutter/core/utils/ui_utils.dart';
import 'package:nahj_balagha_flutter/shared/components/collection_view_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/input_field_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class PhoneInputFieldWidget extends StatefulWidget {
  final ValidCallBack? onChanged;
  final ValidCallBack? onPhoneNumberChanged;
  final Function(MultiItem)? onCountryChanged;
  final VoidCallback? onTap;
  final double? width;
  final bool readOnly;
  final bool enabled;
  final TextEditingController controller;
  final MultiItem? initialCountry;

  const PhoneInputFieldWidget({
    super.key,
    this.onChanged,
    this.onPhoneNumberChanged,
    this.onCountryChanged,
    required this.controller,
    this.width,
    this.onTap,
    this.readOnly = false,
    this.enabled = false,
    this.initialCountry,
  });

  @override
  State<PhoneInputFieldWidget> createState() => _PhoneInputFieldWidgetState();
}

class _PhoneInputFieldWidgetState extends State<PhoneInputFieldWidget> {
  late final ValueNotifier<MultiItem> _selectedCountryNotifier;
  final TextEditingController _searchController = TextEditingController();
  late final ValueNotifier<List<MultiItem>> _filteredCountriesNotifier;

  @override
  void initState() {
    super.initState();
    _selectedCountryNotifier = ValueNotifier(_initializeCountry());
    _filteredCountriesNotifier = ValueNotifier(itemsCountry);
    _searchController.addListener(_filterCountries);
  }

  @override
  void dispose() {
    _selectedCountryNotifier.dispose();
    _searchController.dispose();
    _filteredCountriesNotifier.dispose();
    super.dispose();
  }

  void _filterCountries() {
    final query = _searchController.text.toLowerCase().trim();

    if (query.isEmpty) {
      _filteredCountriesNotifier.value = itemsCountry;
      return;
    }

    final lang = Localizations.localeOf(context).languageCode;
    _filteredCountriesNotifier.value = itemsCountry.where((country) {
      final countryName = labelOf(country, lang).toLowerCase();
      final dialCode = (country.dialCode ?? '').toLowerCase();

      return countryName.contains(query) || dialCode.contains(query);
    }).toList();
  }

  MultiItem _initializeCountry() {
    if (widget.controller.text.isNotEmpty &&
        widget.controller.text.contains(' ')) {
      final countryAndPhone = _extractCountryFromFullNumber(
        widget.controller.text,
      );
      final selectedCountry = countryAndPhone['country'] ?? itemsCountry.first;

      String phoneWithoutCountryCode = countryAndPhone['phone'] ?? '';
      if (phoneWithoutCountryCode.isNotEmpty) {
        widget.controller.text = phoneWithoutCountryCode;
      }

      return selectedCountry;
    } else if (widget.initialCountry != null) {
      return widget.initialCountry!;
    }

    return itemsCountry.first;
  }

  Map<String, dynamic> _extractCountryFromFullNumber(String fullNumber) {
    String cleanNumber = fullNumber.replaceAll(RegExp(r'[^\d+]'), '');

    for (MultiItem country in itemsCountry) {
      String dialCode = country.dialCode ?? '';
      if (dialCode.isNotEmpty && cleanNumber.startsWith(dialCode)) {
        String phoneWithoutCountryCode = cleanNumber.substring(dialCode.length);
        if (phoneWithoutCountryCode.startsWith('0')) {
          phoneWithoutCountryCode = phoneWithoutCountryCode.substring(1);
        }
        return {'country': country, 'phone': phoneWithoutCountryCode};
      }
    }

    return {'country': itemsCountry.first, 'phone': cleanNumber};
  }

  // Method to normalize phone number (remove leading zero)
  String _normalizePhoneNumber(String phoneNumber) {
    // Remove any non-digit characters first
    String digitsOnly = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');

    // Remove leading zero if present
    if (digitsOnly.startsWith('0')) {
      digitsOnly = digitsOnly.substring(1);
    }

    return digitsOnly;
  }

  void _showCountryPicker() {
    // Reset search when opening picker
    _searchController.clear();
    _filteredCountriesNotifier.value = itemsCountry;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        final lang = Localizations.localeOf(context).languageCode;
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return Container(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                // color: context.sheetBackground,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(RADIUS),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    textDirection: Directionality.of(context),
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: HORIZONTAL,
                        ),
                        child: TextWidget(
                          title: "اختر البلد",
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),

                  // Search Field
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: HORIZONTAL,
                      vertical: 5,
                    ),
                    child: InputFieldWidget(
                      controller: _searchController,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      hintText: "بحث عن الدولة",
                      // iconAsset: AppAssets().searchIcon,
                      imageType: ImageType.svg,
                      spacing: 0,
                    ),
                  ),
                  Expanded(
                    child: ValueListenableBuilder<List<MultiItem>>(
                      valueListenable: _filteredCountriesNotifier,
                      builder: (context, filteredCountries, child) {
                        if (filteredCountries.isEmpty) {
                          return Center(
                            child: TextWidget(
                              title: "لا يوجد نتائج",
                              fontSize: 16,
                            ),
                          );
                        }

                        return CollectionViewWidget(
                          controller: scrollController,
                          itemCount: filteredCountries.length,
                          horizontal: 0,
                          vertical: 0,
                          scrollDirection: Axis.vertical,
                          separatorBuilder: (context, index) =>
                              const SizedBox.shrink(),
                          itemBuilder: (context, index) {
                            final country = filteredCountries[index];
                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: HORIZONTAL,
                              ),
                              minVerticalPadding: 0,
                              minTileHeight: 50,

                              leading: Text(
                                country.flag ?? '🏳️',
                                style: const TextStyle(fontSize: 24),
                              ),
                              title: TextWidget(
                                title: labelOf(country, lang),
                                fontSize: 16,
                              ),
                              trailing: TextWidget(
                                title: country.dialCode ?? '',
                                fontSize: 14,
                                textDirection: TextDirection.ltr,
                              ),
                              onTap: () {
                                // Update the ValueNotifier instead of setState
                                _selectedCountryNotifier.value = country;
                                Navigator.pop(context);
                                widget.onCountryChanged?.call(country);

                                // Send normalized phone number without leading zero
                                if (widget.controller.text.isNotEmpty) {
                                  String normalizedNumber =
                                      _normalizePhoneNumber(
                                        widget.controller.text,
                                      );
                                  widget.onPhoneNumberChanged?.call(
                                    normalizedNumber,
                                  );
                                }
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<MultiItem>(
      valueListenable: _selectedCountryNotifier,
      builder: (context, selectedCountry, child) {
        return InputFieldWidget(
          hintText: "7823456789",
          title: "رقم الجوال",
          enabled: widget.enabled,
          onTap: widget.onTap,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.phone,
          controller: widget.controller,
          readOnly: widget.readOnly,
          maxLines: 1,
          valid: (value) {
            // Validate using the normalized phone number (without leading zero)
            String normalizedValue = _normalizePhoneNumber(value ?? '');
            return UiUtils.validatePhone(
              value: normalizedValue,
              country: selectedCountry,
              context: context,
            );
          },

          onChanged: (value) {
            widget.onChanged?.call(value);

            // Always send the normalized phone number (without leading zero) in callbacks

            String normalizedNumber = _normalizePhoneNumber(value ?? "");
            widget.onPhoneNumberChanged?.call(normalizedNumber);
            return null;
          },

          suffixIcon: InkWell(
            onTap: widget.readOnly ? null : _showCountryPicker,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 5,
                children: [
                  Container(
                    width: 1.5,
                    height: 25,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      color: AppColorsLight.accent,
                      borderRadius: BorderRadius.circular(RADIUS),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down_outlined,
                    color: AppColorsLight.accent,
                  ),
                  TextWidget(
                    title: selectedCountry.dialCode ?? '',
                    fontSize: 12,
                    color: AppColorsLight.black,
                    textDirection: TextDirection.ltr,
                  ),
                  TextWidget(
                    title: selectedCountry.flag ?? '🏳️',
                    fontSize: 30,
                    fontFamily: null,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
