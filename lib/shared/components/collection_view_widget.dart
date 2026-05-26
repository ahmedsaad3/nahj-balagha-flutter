import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/typedef.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class CollectionViewWidget extends StatelessWidget {
  final CollectionLayout layout;
  final int itemCount;
  final ItemBuilderCallBack itemBuilder;

  final ScrollController? controller;
  final ScrollPhysics? physics;
  final double horizontal;
  final double vertical;
  final ItemBuilderCallBack? separatorBuilder;

  final bool isLoadingMore;
  final int shimmerCount;

  final Widget? shimmerWidget;

  final bool showMore;
  final VoidCallback? onMoreTap;

  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double? aspectRatio;
  final double mainAxisExtent;

  final Axis scrollDirection;
  final double? itemExtent;

  const CollectionViewWidget({
    super.key,
    this.layout = CollectionLayout.list,
    required this.itemCount,
    required this.itemBuilder,

    this.controller,
    this.physics,
    this.horizontal = HORIZONTAL,
    this.vertical = PADDING_BOTTOM,
    this.separatorBuilder,

    this.isLoadingMore = false,
    this.shimmerCount = 6,
    this.shimmerWidget,

    this.showMore = false,
    this.onMoreTap,

    // Grid
    this.crossAxisCount = 3,
    this.mainAxisSpacing = 12,
    this.crossAxisSpacing = 12,
    this.aspectRatio,
    this.mainAxisExtent = 240,

    // List
    this.scrollDirection = Axis.vertical,
    this.itemExtent,
  });

  @override
  Widget build(BuildContext context) {
    final int extraLoading = isLoadingMore ? shimmerCount : 0;
    final int extraMore = showMore ? 1 : 0;
    final int totalItemCount = itemCount + extraLoading + extraMore;

    Widget buildShimmer(BuildContext ctx, int shimmerIndex) {
      return shimmerWidget!;
    }

    Widget builder(BuildContext ctx, int index) {
      if (showMore && index == totalItemCount - 1) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL),
          child: InkWell(
            onTap: onMoreTap,
            borderRadius: BorderRadius.circular(RADIUS),
            child: Column(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(ctx).size.height * 0.07),
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColorsLight.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chevron_right,
                    size: 35,
                    color: AppColorsLight.secondary,
                  ),
                ),
                const TextWidget(
                  title: "المزيد",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
              ],
            ),
          ),
        );
      }

      if (isLoadingMore &&
          index >= itemCount &&
          index < itemCount + shimmerCount) {
        final localShimmerIndex = index - itemCount;
        return buildShimmer(ctx, localShimmerIndex);
      }

      return itemBuilder(ctx, index);
    }

    final EdgeInsetsGeometry resolvedPadding = EdgeInsetsDirectional.symmetric(
      vertical: vertical,
      horizontal: horizontal,
    );

    if (layout == CollectionLayout.grid) {
      final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: aspectRatio ?? 1.0,
        mainAxisExtent: aspectRatio == null ? (mainAxisExtent) : null,
      );

      return GridView.builder(
        controller: controller,
        physics: physics,
        shrinkWrap: true,
        padding: resolvedPadding,
        gridDelegate: gridDelegate,
        itemCount: totalItemCount,
        itemBuilder: builder,
      );
    }

    // List (Separated)
    final sep =
        separatorBuilder ??
        (context, index) => scrollDirection == Axis.horizontal
            ? const SizedBox(width: 12)
            : const SizedBox(height: 12);

    if (itemExtent == null) {
      return ListView.separated(
        controller: controller,
        physics: physics,
        primary: false,
        shrinkWrap: true,
        padding: resolvedPadding,
        scrollDirection: scrollDirection,
        itemCount: totalItemCount,
        itemBuilder: builder,
        separatorBuilder: sep,
      );
    }

    // itemExtent + separator workaround
    return _SeparatedWithExtentListView(
      controller: controller,
      physics: physics,
      padding: resolvedPadding,
      scrollDirection: scrollDirection,
      itemCount: totalItemCount,
      itemExtent: itemExtent!,
      itemBuilder: builder,
      separatorBuilder: sep,
    );
  }
}

class _SeparatedWithExtentListView extends StatelessWidget {
  final ScrollController? controller;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final Axis scrollDirection;
  final int itemCount;
  final double itemExtent;
  final ItemBuilderCallBack itemBuilder;
  final ItemBuilderCallBack separatorBuilder;

  const _SeparatedWithExtentListView({
    this.controller,
    this.physics,
    this.padding,
    required this.scrollDirection,
    required this.itemCount,
    required this.itemExtent,
    required this.itemBuilder,
    required this.separatorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final isHorizontal = scrollDirection == Axis.horizontal;
    return ListView.builder(
      controller: controller,
      physics: physics,
      padding: padding,
      scrollDirection: scrollDirection,
      primary: false,
      shrinkWrap: true,
      itemCount: itemCount == 0 ? 0 : itemCount * 2 - 1,
      itemBuilder: (ctx, i) {
        final isSeparator = i.isOdd;
        if (isSeparator) {
          final index = i ~/ 2;
          return separatorBuilder(ctx, index);
        } else {
          final index = i ~/ 2;
          return SizedBox(
            width: isHorizontal ? itemExtent : null,
            height: isHorizontal ? null : itemExtent,
            child: itemBuilder(ctx, index),
          );
        }
      },
    );
  }
}
