import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/features/browse/presentation/screens/browse_screen.dart';
import 'package:nahj_balagha_flutter/features/favorites/presentation/screens/favorite_screen.dart';
import 'package:nahj_balagha_flutter/features/home/presentation/screens/home_screen.dart';
import 'package:nahj_balagha_flutter/features/navigation/presentation/controller/navigation_state.dart';
import 'package:nahj_balagha_flutter/features/search/presentation/screens/search_screen.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit()
    : super(
        const NavigationState(
          screens: [
            HomeScreen(),
            SearchScreen(),
            BrowseScreen(),
            FavoritesScreen(),
          ],
        ),
      );

  void onItemTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
    if (state.selectedIndex == index && state.replacedScreens.isNotEmpty) {
      backFromReplacedScreen(screenIndex: index);
    }
  }

  void updateSelectedIndex() {
    emit(state.copyWith(selectedIndex: 0));
  }

  void replaceCurrentScreen(Widget newScreen) {
    final updatedReplacedScreens = Map<int, Widget>.from(state.replacedScreens);
    updatedReplacedScreens[state.selectedIndex] = newScreen;

    emit(state.copyWith(replacedScreens: updatedReplacedScreens));
  }

  void backFromReplacedScreen({int? screenIndex}) {
    final targetIndex = screenIndex ?? state.selectedIndex;
    final updatedReplacedScreens = Map<int, Widget>.from(state.replacedScreens);
    updatedReplacedScreens.remove(targetIndex);
    emit(state.copyWith(replacedScreens: updatedReplacedScreens));
  }
}
