import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/ui_utils.dart';
import 'package:nahj_balagha_flutter/features/browse/domain/entities/browse_node.dart';
import 'package:nahj_balagha_flutter/features/browse/presentation/components/ContentSnippetWidget.dart';
import 'package:nahj_balagha_flutter/shared/components/breadcrumbs_widget.dart';
import 'package:nahj_balagha_flutter/features/browse/presentation/components/browse_node_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/collection_view_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class CategoryScreen extends StatefulWidget {
  final List<BrowseNode> trail;

  const CategoryScreen({super.key, required this.trail});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.trail.isEmpty) {
      return const Scaffold(
        body: Center(child: TextWidget(title: 'تصنيف غير موجود')),
      );
    }

    final activeNode = widget.trail.last;

    return Scaffold(
      appBar: UiUtils.appBar(context: context),
      body: Column(
        children: [
          // Breadcrumbs navigation trail bar
          BreadcrumbsWidget(trail: widget.trail),
          Expanded(child: _buildContent(activeNode)),
        ],
      ),
    );
  }

  Widget _buildContent(BrowseNode activeNode) {
    // Case 1: Alphabetical view (e.g. الأعلام)
    if (activeNode.isAlphabetical) {
      return _buildAlphabeticalView(activeNode.children);
    }

    // Case 2: Children are leaf nodes containing content snippets (e.g. العلم -> التعليم/الجهل)
    final isLeafAccordion =
        activeNode.children.isNotEmpty &&
        activeNode.children.any((child) => child.content.isNotEmpty);

    if (isLeafAccordion) {
      return _buildAccordionView(activeNode.children);
    }

    // Case 3: Direct content list (no subcategories, but contains contents directly)
    if (activeNode.children.isEmpty && activeNode.content.isNotEmpty) {
      return _buildDirectContentView(activeNode.content);
    }

    // Case 4: Standard subcategories list (e.g. المعجم الموضوعي -> list of topics)
    return _buildNestedSubcategoriesView(activeNode.children);
  }

  Widget _buildAlphabeticalView(List<BrowseNode> alphabeticalLetters) {
    return CollectionViewWidget(
      itemCount: alphabeticalLetters.length,
      horizontal: 0,
      vertical: 0,
      itemBuilder: (context, index) {
        final letterNode = alphabeticalLetters[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL),
              child: TextWidget(
                title: letterNode.title,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColorsLight.secondary,
              ),
            ),
            ...letterNode.children.map((figureNode) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: BrowseNodeWidget(
                  title: figureNode.title,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.categoryScreen,
                      arguments: [...widget.trail, letterNode, figureNode],
                    );
                  },
                ),
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildAccordionView(List<BrowseNode> leafSubcategories) {
    return CollectionViewWidget(
      itemCount: leafSubcategories.length,
      horizontal: 0,
      vertical: 0,
      itemBuilder: (context, index) {
        final subNode = leafSubcategories[index];
        return BrowseNodeWidget(
          title: subNode.title,
          count: subNode.count,
          content: subNode.content,
          onSnippetTap: (snippet) {
            Navigator.pushNamed(
              context,
              AppRoutes.contentReaderScreen,
              arguments: {
                'contentId': snippet.id,
                'trail': [...widget.trail, subNode],
              },
            );
          },
        );
      },
    );
  }

  Widget _buildDirectContentView(List<ContentSnippet> contentList) {
    return CollectionViewWidget(
      itemCount: contentList.length,
      horizontal: 0,
      itemBuilder: (context, index) {
        final snippet = contentList[index];
        return ContentSnippetWidget(
          title: snippet.title,
          description: snippet.excerpt,
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.contentReaderScreen,
              arguments: {'contentId': snippet.id, 'trail': widget.trail},
            );
          },
        );
      },
    );
  }

  Widget _buildNestedSubcategoriesView(List<BrowseNode> subcategories) {
    return CollectionViewWidget(
      itemCount: subcategories.length,
      horizontal: 0,
      vertical: 0,
      itemBuilder: (context, index) {
        final subNode = subcategories[index];
        return BrowseNodeWidget(
          title: subNode.title,
          count: subNode.count,
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.categoryScreen,
              arguments: [...widget.trail, subNode],
            );
          },
        );
      },
    );
  }
}
