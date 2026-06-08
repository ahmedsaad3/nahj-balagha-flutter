import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/features/search/presentation/components/filter_bottom_sheet.dart';
import 'package:nahj_balagha_flutter/features/search/presentation/components/search_text_highlight.dart';
import 'package:nahj_balagha_flutter/features/search/presentation/controller/search_cubit.dart';
import 'package:nahj_balagha_flutter/features/search/presentation/controller/search_state.dart';
import 'package:nahj_balagha_flutter/features/browse/domain/entities/browse_node.dart';
import 'package:nahj_balagha_flutter/features/browse/presentation/components/ContentSnippetWidget.dart';
import 'package:nahj_balagha_flutter/shared/components/circular_progress_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/collection_view_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/empty_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/input_field_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchCubit>().performSearch();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _openFilterBottomSheet() async {
    final cubit = context.read<SearchCubit>();
    final selectedFilter = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          FilterBottomSheet(initialFilter: cubit.state.activeFilter),
    );

    if (selectedFilter != null) {
      cubit.updateFilter(selectedFilter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return FloatingActionButton.extended(
            onPressed: _openFilterBottomSheet,
            backgroundColor: AppColorsLight.primary,
            icon: const Icon(Icons.filter_alt, color: AppColorsLight.white),
            extendedPadding: const EdgeInsets.symmetric(horizontal: 16),
            label: TextWidget(
              title: state.activeFilter,
              color: AppColorsLight.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          );
        },
      ),
      body: Column(
        children: [
          // Search Bar & Filters Section
          Container(
            color: AppColorsLight.white,
            padding: const EdgeInsets.symmetric(
              horizontal: HORIZONTAL,
              vertical: 12,
            ),
            child: InputFieldWidget(
              hintText: 'ابحث عن كلمة، موضوع، أو إعراب...',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.search,
              controller: _searchController,
              onChanged: (query) {
                if (query != null) {
                  context.read<SearchCubit>().updateSearchQuery(query);
                }
                return null;
              },
              suffixIcon: Icon(Icons.search, color: AppColorsLight.primary),
            ),
          ),

          // Search Results / States Section
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state.searchState == RequestState.loading) {
                  return const CircularProgressWidget();
                }

                if (state.results.isEmpty) {
                  return EmptyWidget(
                    title: state.searchQuery.isEmpty
                        ? 'ابحث في معارف نهج البلاغة'
                        : 'لا توجد نتائج مطابقة',
                    message: state.searchQuery.isEmpty
                        ? 'اكتب كلمة البحث أو اختر من الفلاتر لتصفية مواضيع الخطب والرسائل والحكم'
                        : 'تأكد من كتابة الكلمة بشكل صحيح، أو جرب تغيير نطاق البحث أو الفلتر النشط',
                    icon: Icons.search_off_rounded,
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Results Counter
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                      child: Text(
                        'تم العثور على (${state.results.length}) نتيجة',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: FONT_FAMILY_CAIRO,
                          color: AppColorsLight.gray,
                        ),
                      ),
                    ),

                    // Results ListView
                    Expanded(
                      child: CollectionViewWidget(
                        itemCount: state.results.length,
                        horizontal: 0,
                        itemBuilder: (context, index) {
                          final result = state.results[index];
                          final snippet = _generateSnippet(
                            result.content,
                            state.searchQuery,
                          );
                          return ContentSnippetWidget(
                            title: result.title,
                            descriptionWidget: SearchTextHighlight(
                              text: snippet,
                              query: state.searchQuery,
                              textStyle: const TextStyle(
                                fontSize: 13,
                                height: 1.8,
                                fontFamily: FONT_FAMILY_CAIRO,
                                color: AppColorsLight.textPrimary,
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.contentReaderScreen,
                                arguments: {
                                  'contentId': result.id,
                                  'trail': const <BrowseNode>[],
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String _generateSnippet(String text, String query) {
    if (query.trim().isEmpty) {
      return text.length > 140 ? '${text.substring(0, 140)}...' : text;
    }

    final String normalizedText = _normalizeArabic(text);
    final String normalizedQuery = _normalizeArabic(query.trim());

    final int index = normalizedText.indexOf(normalizedQuery);
    if (index == -1) {
      return text.length > 140 ? '${text.substring(0, 140)}...' : text;
    }

    // Find the original char position corresponding to normalized index
    int originalIndex = 0;
    int normalizedCharCount = 0;

    while (originalIndex < text.length && normalizedCharCount < index) {
      final String char = text[originalIndex];
      // Skip Arabic diacritics
      if (!RegExp(r'[\u064B-\u0652\u0670]').hasMatch(char)) {
        normalizedCharCount++;
      }
      originalIndex++;
    }

    int start = originalIndex - 50;
    if (start < 0) start = 0;

    // Adjust start to beginning of a word
    if (start > 0) {
      final int nextSpace = text.indexOf(' ', start);
      if (nextSpace != -1 && nextSpace - start < 15) {
        start = nextSpace + 1;
      }
    }

    int end = originalIndex + query.length + 90;
    if (end > text.length) end = text.length;

    // Adjust end to end of a word
    if (end < text.length) {
      final int prevSpace = text.lastIndexOf(' ', end);
      if (prevSpace != -1 && end - prevSpace < 15) {
        end = prevSpace;
      }
    }

    String snippet = text.substring(start, end).trim();
    if (start > 0) snippet = '...$snippet';
    if (end < text.length) snippet = '$snippet...';

    return snippet;
  }

  String _normalizeArabic(String text) {
    String normalized = text;
    normalized = normalized.replaceAll(RegExp(r'[\u064B-\u0652\u0670]'), '');
    normalized = normalized.replaceAll(RegExp(r'[أإآ]'), 'ا');
    normalized = normalized.replaceAll(RegExp(r'ة'), 'ه');
    normalized = normalized.replaceAll(RegExp(r'ى'), 'ي');
    return normalized.toLowerCase();
  }
}
