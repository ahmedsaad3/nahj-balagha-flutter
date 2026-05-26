import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/typedef.dart';
import 'package:nahj_balagha_flutter/shared/components/soft_divider_widget.dart.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class DropdownController extends ValueNotifier<String?> {
  DropdownController([super.value]);
}

class DropdownWidget extends StatefulWidget {
  final ValidCallBack onChanged;
  final ValidCallBack? valid;
  final String? hintText;
  final Widget? prefixIcon;
  final List<DropdownMenuItem<String>> items;
  final double? width;
  final String? value;
  final bool disabled;
  final DropdownController? controller;
  final EdgeInsets? padding;
  final BorderSide borderSide;
  final Color? suffixIconColor;

  const DropdownWidget({
    super.key,
    required this.onChanged,
    required this.items,
    this.width,
    this.hintText,
    this.valid,
    this.disabled = false,
    this.prefixIcon,
    this.value,
    this.controller,
    this.padding,
    this.borderSide = BorderSide.none,
    this.suffixIconColor = AppColorsLight.primary,
  });

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  late final DropdownController _controller;
  late final bool _ownsController;

  @override
  void initState() {
    super.initState();

    // Prefer external controller; otherwise create our own.
    _ownsController = widget.controller == null;
    _controller = widget.controller ?? DropdownController(widget.value);

    // If an initial value was provided and differs, set it once.
    if (widget.value != null && widget.value != _controller.value) {
      _controller.value = widget.value;
    }
  }

  @override
  void didUpdateWidget(covariant DropdownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // If the list of items changes and current value is not present, clear it.
    final validValues = widget.items.map((e) => e.value).toSet();
    if (_controller.value != null && !validValues.contains(_controller.value)) {
      _controller.value = null;
    }

    // If parent updates the initial value explicitly, sync it.
    if (widget.value != oldWidget.value && widget.value != _controller.value) {
      _controller.value = widget.value;
    }
  }

  @override
  void dispose() {
    if (_ownsController) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: ValueListenableBuilder<String?>(
        valueListenable: _controller,
        builder: (context, selectedValue, _) {
          // Ensure current value exists in items; otherwise keep it null.
          final itemValues = widget.items.map((e) => e.value).toSet();
          final safeValue =
              (selectedValue != null && itemValues.contains(selectedValue))
              ? selectedValue
              : null;

          final dropdown = DropdownButtonFormField<String>(
            initialValue: safeValue,
            padding: widget.padding,
            // menuMaxHeight: context.dimensions.screenHeight * 0.4,
            borderRadius: BorderRadius.circular(RADIUS),
            decoration: InputDecoration(
              enabled: !widget.disabled,
              suffixIcon: Icon(
                Icons.arrow_drop_down,
                color: widget.suffixIconColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(RADIUS),
                borderSide: widget.borderSide,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(RADIUS),
                borderSide: widget.borderSide,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(RADIUS),
                borderSide: widget.borderSide,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(RADIUS),
                borderSide: const BorderSide(
                  color: AppColorsLight.red,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(RADIUS),
                borderSide: const BorderSide(
                  color: AppColorsLight.red,
                  width: 1,
                ),
              ),
              errorStyle: const TextStyle(
                fontFamily: FONT_FAMILY_CAIRO,
                fontSize: 10,
              ),
              errorMaxLines: 1,
              filled: true,
              fillColor: AppColorsLight.white,

              contentPadding: EdgeInsets.zero,
            ),
            isExpanded: widget.width != null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.valid,
            hint: widget.hintText != null
                ? TextWidget(
                    title: widget.hintText!,
                    alignment: TextAlign.center,
                    fontSize: 12.0,
                    color: AppColorsLight.primary.withAlpha(80),
                    fontFamily: FONT_FAMILY_CAIRO,
                  )
                : null,
            onChanged: widget.disabled
                ? null
                : (newValue) {
                    _controller.value = newValue;
                    widget.onChanged(newValue);
                  },
            selectedItemBuilder: (BuildContext context) {
              return widget.items.map<Widget>((DropdownMenuItem<String> item) {
                return item.child;
              }).toList();
            },
            items: widget.items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;

              return DropdownMenuItem<String>(
                value: item.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 20,
                      ),
                      child: item.child,
                    ),
                    if (index < widget.items.length - 1)
                      const SoftDividerWidget(color: AppColorsLight.primary),
                  ],
                ),
              );
            }).toList(),
            elevation: 6,
            dropdownColor: AppColorsLight.white,
          );

          if (widget.width == null) {
            return IntrinsicWidth(child: dropdown);
          }
          return dropdown;
        },
      ),
    );
  }
}
