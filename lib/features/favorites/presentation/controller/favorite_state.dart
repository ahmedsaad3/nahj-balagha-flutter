import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/favorites/domain/entities/favorite_item.dart';

class FavoriteState extends Equatable {
  final List<FavoriteItem> favorites;
  final String activeCategory;
  final RequestState favoritesState;
  final String favoritesMessage;

  const FavoriteState({
    this.favorites = const [],
    this.activeCategory = 'الكل',
    this.favoritesState = RequestState.idle,
    this.favoritesMessage = '',
  });

  FavoriteState copyWith({
    List<FavoriteItem>? favorites,
    String? activeCategory,
    RequestState? favoritesState,
    String? favoritesMessage,
  }) {
    return FavoriteState(
      favorites: favorites ?? this.favorites,
      activeCategory: activeCategory ?? this.activeCategory,
      favoritesState: favoritesState ?? this.favoritesState,
      favoritesMessage: favoritesMessage ?? this.favoritesMessage,
    );
  }

  @override
  List<Object?> get props => [
        favorites,
        activeCategory,
        favoritesState,
        favoritesMessage,
      ];
}
