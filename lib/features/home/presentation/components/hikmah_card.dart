import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/images.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/ui_utils.dart';
import 'package:nahj_balagha_flutter/features/home/domain/entities/hikmah_entity.dart';
import 'package:nahj_balagha_flutter/shared/components/app_image_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/soft_divider_widget.dart.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class HikmahCard extends StatefulWidget {
  final HikmahEntity hikmah;

  const HikmahCard({super.key, required this.hikmah});

  @override
  State<HikmahCard> createState() => _HikmahCardState();
}

class _HikmahCardState extends State<HikmahCard> {
  bool _isExpanded = false;

  void _showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(RADIUS)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextWidget(
                  title: "خيارات مشاركة الحكمة",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColorsLight.primary,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.copy, color: AppColorsLight.primary),
                title: const TextWidget(
                  title: "مشاركة الحكمة فقط",
                  fontSize: 14,
                ),
                onTap: () {
                  Navigator.pop(context);
                  _copyToClipboard(context, widget.hikmah.text);
                },
              ),
              if (widget.hikmah.benefit != null)
                ListTile(
                  leading: const Icon(
                    Icons.copy,
                    color: AppColorsLight.primary,
                  ),
                  title: const TextWidget(
                    title: "مشاركة الحكمة مع الفائدة",
                    fontSize: 14,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _copyToClipboard(
                      context,
                      "${widget.hikmah.text}\n\nالفائدة:\n${widget.hikmah.benefit}",
                    );
                  },
                ),
              if (widget.hikmah.benefit != null &&
                  widget.hikmah.gharib != null)
                ListTile(
                  leading: const Icon(
                    Icons.copy,
                    color: AppColorsLight.primary,
                  ),
                  title: const TextWidget(
                    title: "مشاركة الحكمة مع الفائدة وغريب اللغة",
                    fontSize: 14,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _copyToClipboard(
                      context,
                      "${widget.hikmah.text}\n\nالفائدة:\n${widget.hikmah.benefit}\n\nغريب اللغة:\n${widget.hikmah.gharib}",
                    );
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    UiUtils.toastMessage(
      context: context,
      message: "تم نسخ النص إلى الحافظة بنجاح!",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(PADDING_BOTTOM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(RADIUS),
        boxShadow: [UiUtils.softShadow()],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppImageWidget(path: AppAssets().wisdomManuscript, scale: 1.5),
          const SizedBox(height: 20),

          // Wisdom Text
          TextWidget(
            title: widget.hikmah.text,
            fontSize: 14,
            height: 1.8,
            color: AppColorsLight.textPrimary,
            alignment: TextAlign.center,
            fontWeight: FontWeight.w500,
          ),
          const SizedBox(height: 12),

          // // Source
          // TextWidget(
          //   title: widget.wisdom.source,
          //   fontSize: 11,
          //   color: AppColorsLight.gray,
          // ),
          // const SizedBox(height: 10),

          // Expand / Share Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: TextWidget(
                    title: _isExpanded ? "عرض أقل..." : "المزيد...",
                    fontSize: 12,
                    color: AppColorsLight.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.share_outlined,
                  color: AppColorsLight.primary,
                  size: 20,
                ),
                onPressed: () => _showShareOptions(context),
              ),
            ],
          ),

          // Expanded Area
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SoftDividerWidget(margin: EdgeInsets.only(bottom: 10)),
                if (widget.hikmah.benefit != null) ...[
                  const TextWidget(
                    title: "الفائدة:",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColorsLight.accent,
                  ),
                  const SizedBox(height: 4),
                  TextWidget(
                    title: widget.hikmah.benefit!,
                    fontSize: 14,
                    height: 1.6,
                    color: AppColorsLight.textPrimary,
                  ),
                  const SizedBox(height: 12),
                ],
                if (widget.hikmah.gharib != null) ...[
                  const TextWidget(
                    title: "غريب اللغة:",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColorsLight.accent,
                  ),
                  const SizedBox(height: 4),
                  TextWidget(
                    title: widget.hikmah.gharib!,
                    fontSize: 14,
                    height: 1.6,
                    color: AppColorsLight.textPrimary,
                  ),
                ],
              ],
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
