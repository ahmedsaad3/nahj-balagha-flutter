import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/images.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/browse/domain/entities/browse_node.dart';
import 'package:nahj_balagha_flutter/shared/components/app_image_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/collection_view_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class BrowseNodeWidget extends StatelessWidget {
  final String title;
  final String? count;
  final VoidCallback? onTap;
  final List<ContentSnippet>? content;
  final Function(ContentSnippet)? onSnippetTap;

  const BrowseNodeWidget({
    super.key,
    required this.title,
    this.count,
    this.onTap,
    this.content,
    this.onSnippetTap,
  });

  bool get _isExpandable => content != null && content!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColorsLight.gray.withAlpha(50)),
      clipBehavior: Clip.antiAlias,
      child: _isExpandable
          ? _buildExpansionTile(context)
          : _buildSimpleListTile(context),
    );
  }

  Widget _buildSimpleListTile(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: HORIZONTAL),
      onTap: onTap,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(title: title, fontSize: 16, fontWeight: FontWeight.w500),
          if (count != null)
            TextWidget(
              title: count!,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColorsLight.gray,
            ),
        ],
      ),
    );
  }

  Widget _buildExpansionTile(BuildContext context) {
    return _BrowseExpansionContent(
      title: title,
      count: count,
      content: content!,
      onSnippetTap: onSnippetTap!,
    );
  }
}

class _BrowseExpansionContent extends StatefulWidget {
  final String title;
  final String? count;
  final List<ContentSnippet> content;
  final Function(ContentSnippet) onSnippetTap;

  const _BrowseExpansionContent({
    required this.title,
    this.count,
    required this.content,
    required this.onSnippetTap,
  });

  @override
  State<_BrowseExpansionContent> createState() =>
      _BrowseExpansionContentState();
}

class _BrowseExpansionContentState extends State<_BrowseExpansionContent> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: HORIZONTAL),
      shape: RoundedRectangleBorder(side: BorderSide.none),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            title: widget.title,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColorsLight.textPrimary,
          ),
          if (widget.count != null)
            TextWidget(
              title: widget.count!,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColorsLight.textPrimary.withAlpha(180),
            ),
        ],
      ),
      trailing: Icon(
        _isExpanded
            ? Icons.keyboard_arrow_down_rounded
            : Icons.chevron_left_rounded,
        color: AppColorsLight.secondary,
        size: 24,
      ),
      onExpansionChanged: (expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      children: [
        CollectionViewWidget(
          itemCount: widget.content.length,
          vertical: 0,
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: AppImageWidget(path: AppAssets().commaAyat, scale: 1.2),
          ),
          itemBuilder: (context, index) {
            final snippet = widget.content[index];
            return GestureDetector(
              onTap: () => widget.onSnippetTap(snippet),
              behavior: HitTestBehavior.opaque,
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextWidget(title: snippet.title, fontSize: 14),
                  TextWidget(
                    title: snippet.excerpt,
                    fontSize: 14,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
