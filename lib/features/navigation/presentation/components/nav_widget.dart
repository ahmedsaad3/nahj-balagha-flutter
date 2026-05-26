import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/images.dart';
import 'package:nahj_balagha_flutter/core/utils/typedef.dart';
import 'package:nahj_balagha_flutter/features/navigation/presentation/components/custom_nav_icon.dart';

Widget navWidget({
  required VoidValidCallBackInt onTap,
  required int currentIndex,
  required BuildContext context,
}) {
  return BottomNavigationBar(
    currentIndex: currentIndex,
    onTap: onTap,
    iconSize: 10,
    selectedFontSize: 10,
    unselectedFontSize: 10,

    items: [
      BottomNavigationBarItem(
        icon: CustomNavIcon(
          iconAsset: AppAssets().homeIcon,
          isActive: currentIndex == 0,
        ),
        activeIcon: CustomNavIcon(
          iconAsset: AppAssets().homeSolidIcon,
          isActive: currentIndex == 0,
        ),
        label: "الرئيسية",
      ),
      BottomNavigationBarItem(
        icon: CustomNavIcon(
          iconAsset: AppAssets().searchIcon,
          isActive: currentIndex == 1,
        ),
        activeIcon: CustomNavIcon(
          iconAsset: AppAssets().searchSolidIcon,
          isActive: currentIndex == 1,
        ),
        label: "بحث",
      ),
      BottomNavigationBarItem(
        icon: CustomNavIcon(
          iconAsset: AppAssets().browseIcon,
          isActive: currentIndex == 2,
        ),
        activeIcon: CustomNavIcon(
          iconAsset: AppAssets().browseSolidIcon,
          isActive: currentIndex == 2,
        ),
        label: "تصفح",
      ),
      BottomNavigationBarItem(
        icon: CustomNavIcon(
          iconAsset: AppAssets().favoritesIcon,
          isActive: currentIndex == 3,
        ),
        activeIcon: CustomNavIcon(
          iconAsset: AppAssets().favoritesSolidIcon,
          isActive: currentIndex == 3,
        ),
        label: "المفضلة",
      ),
    ],
  );
}
