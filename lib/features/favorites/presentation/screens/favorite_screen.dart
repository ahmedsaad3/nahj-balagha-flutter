import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/browse/domain/entities/browse_node.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/features/favorites/presentation/components/category_tabs.dart';
import 'package:nahj_balagha_flutter/features/favorites/presentation/components/favorite_card.dart';
import 'package:nahj_balagha_flutter/features/favorites/presentation/controller/favorite_cubit.dart';
import 'package:nahj_balagha_flutter/features/favorites/presentation/controller/favorite_state.dart';
import 'package:nahj_balagha_flutter/shared/components/circular_progress_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/collection_view_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/empty_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/soft_divider_widget.dart.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        if (state.favoritesState == RequestState.loading) {
          return const CircularProgressWidget();
        }

        // Calculate item counts for categories dynamically
        final Map<String, int> counts = {
          'الكل': state.favorites.length,
          'الكتب': state.favorites.where((e) => e.category == 'الكتب').length,
          'الخطب': state.favorites.where((e) => e.category == 'الخطب').length,
          'الرسائل': state.favorites
              .where((e) => e.category == 'الرسائل')
              .length,
          'الإعراب': state.favorites
              .where((e) => e.category == 'الإعراب')
              .length,
          'المفردات': state.favorites
              .where((e) => e.category == 'المفردات')
              .length,
          'صوتيات': state.favorites.where((e) => e.hasAudio).length,
        };

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Category Filter Tabs
            CategoryTabs(
              selectedCategory: state.activeCategory,
              onCategorySelected: (category) {
                context.read<FavoriteCubit>().selectCategory(category);
              },
              categoryCounts: counts,
            ),
            Container(height: 1, color: AppColorsLight.gray.withAlpha(30)),

            // Lower section: List or folder view
            Expanded(child: _buildBodyContent(context, state, counts)),
          ],
        );
      },
    );
  }

  Widget _buildBodyContent(
    BuildContext context,
    FavoriteState state,
    Map<String, int> counts,
  ) {
    // 1. Check if the active category is "الكل" (All)
    // If so, display the Folder view structure matching the screenshot exactly
    if (state.activeCategory == 'الكل') {
      final categoriesWithItems = [
        'الخطب',
        'الرسائل',
        'المفردات',
      ].where((cat) => (counts[cat] ?? 0) > 0).toList();

      if (categoriesWithItems.isEmpty) {
        return const EmptyWidget(
          title: 'المفضلة فارغة',
          message: 'لم تقم بحفظ أي عناصر في المفضلة بعد.',
          icon: Icons.star_border_rounded,
        );
      }

      return Container(
        color: AppColorsLight.white,
        child: CollectionViewWidget(
          itemCount: categoriesWithItems.length,
          separatorBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: SoftDividerWidget(),
          ),
          itemBuilder: (context, index) {
            final category = categoriesWithItems[index];
            final count = counts[category] ?? 0;

            return _buildCategoryRow(
              title: category,
              count: count,
              onTap: () {
                context.read<FavoriteCubit>().selectCategory(category);
              },
            );
          },
        ),
      );
    }

    // 2. Otherwise, filter items by category or audio check
    final filteredItems = state.favorites.where((item) {
      if (state.activeCategory == 'صوتيات') {
        return item.hasAudio;
      }
      return item.category == state.activeCategory;
    }).toList();

    if (filteredItems.isEmpty) {
      return EmptyWidget(
        title: 'لا توجد عناصر',
        message:
            'لا توجد عناصر محفوظة في قسم "${state.activeCategory}" حالياً.',
        icon: Icons.folder_open_rounded,
      );
    }

    // 3. Display list of FavoriteCards
    return CollectionViewWidget(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return FavoriteCard(
          key: ValueKey(item.id),
          item: item,
          onRemove: () {
            context.read<FavoriteCubit>().removeFavorite(item.id);
          },
          onTap: () {
            // Navigate to appropriate screen or reader screen
            Navigator.pushNamed(
              context,
              AppRoutes.contentReaderScreen,
              arguments: {'contentId': item.id, 'trail': const <BrowseNode>[]},
            );
          },
        );
      },
    );
  }

  Widget _buildCategoryRow({
    required String title,
    required int count,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Right: Folder Title and Gold Document Icon
          Row(
            spacing: 10,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: AppColorsLight.secondary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.description_rounded,
                  color: AppColorsLight.white,
                  size: 22,
                ),
              ),
              TextWidget(
                title: title,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: FONT_FAMILY_CAIRO,
              ),
            ],
          ),
          // Left: Count
          TextWidget(
            title: count.toString(),
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColorsLight.gray,
            fontFamily: FONT_FAMILY_CAIRO,
          ),
        ],
      ),
    );
  }
}
