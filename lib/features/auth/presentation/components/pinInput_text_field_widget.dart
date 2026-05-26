import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';

class PinInputTextField extends StatelessWidget {
  final int length;
  final ValueChanged<String> onChanged;
  final List<FocusNode>? focusNodes;
  final TextDirection? textDirection;
  final List<TextEditingController> controllers;
  final bool readOnly;

  const PinInputTextField({
    super.key,
    required this.length,
    required this.onChanged,
    this.focusNodes,
    this.textDirection,
    required this.controllers,
    required this.readOnly,
  });

  void _applyPasted({required BuildContext context, required String raw}) {
    final digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return;

    for (int i = 0; i < length; i++) {
      controllers[i].text = i < digits.length ? digits[i] : '';
    }

    final nextIndex = digits.length >= length ? length - 1 : digits.length;
    if (focusNodes != null && focusNodes!.isNotEmpty) {
      focusNodes![nextIndex].requestFocus();
    }

    final joined = controllers.map((c) => c.text).join();
    onChanged(joined);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(length, (index) {
        return Container(
          width: 60,
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: TextField(
            cursorColor: AppColorsLight.accent,
            textDirection: textDirection,
            controller: controllers[index],
            keyboardType: TextInputType.number,
            readOnly: readOnly,
            focusNode: focusNodes?[index],
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
            maxLength: 1,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1),
            ],
            decoration: const InputDecoration(
              counterText: '',
              // filled: true,
              // fillColor: AppColors.primaryCard,
              // border: OutlineInputBorder(
              //   borderRadius: BorderRadius.circular(20),
              //   borderSide: BorderSide.none,
              // ),
            ),
            contextMenuBuilder: (ctx, editableTextState) {
              final defaultItems = editableTextState.contextMenuButtonItems
                  .where((item) => item.type != ContextMenuButtonType.paste)
                  .toList();

              return AdaptiveTextSelectionToolbar.buttonItems(
                anchors: editableTextState.contextMenuAnchors,
                buttonItems: [
                  ...defaultItems,
                  ContextMenuButtonItem(
                    type: ContextMenuButtonType.paste,
                    onPressed: () async {
                      final data = await Clipboard.getData('text/plain');
                      if (data?.text != null) {
                        _applyPasted(context: ctx, raw: data!.text!);
                      }
                    },
                  ),
                ],
              );
            },
            onChanged: (value) {
              if (value.length > 1) {
                _applyPasted(context: context, raw: value);
                return;
              }

              if (value.isNotEmpty && index < length - 1) {
                FocusScope.of(context).nextFocus();
              }

              final fullOTP = controllers.map((e) => e.text).join();
              onChanged(fullOTP);
            },
            onTap: () {
              controllers[index].selection = TextSelection(
                baseOffset: 0,
                extentOffset: controllers[index].text.length,
              );
            },
          ),
        );
      }),
    );
  }
}
