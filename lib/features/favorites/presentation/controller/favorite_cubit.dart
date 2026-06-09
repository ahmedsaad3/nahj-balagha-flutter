import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/favorites/domain/entities/favorite_item.dart';
import 'package:nahj_balagha_flutter/features/favorites/domain/repository/base_favorite_repository.dart';
import 'package:nahj_balagha_flutter/features/favorites/presentation/controller/favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final BaseFavoriteRepository _favoriteRepository;

  FavoriteCubit(this._favoriteRepository) : super(const FavoriteState());

  Future<void> getFavorites() async {
    emit(state.copyWith(favoritesState: RequestState.loading, favoritesMessage: ''));
    
    final result = await _favoriteRepository.getFavorites();
    
    switch (result) {
      case Success(response: final response):
        emit(
          state.copyWith(
            favoritesState: RequestState.loaded,
            favorites: response,
          ),
        );
      case Failure(response: final msg):
        emit(
          state.copyWith(
            favoritesState: RequestState.error,
            favoritesMessage: msg.toString(),
          ),
        );
    }
  }

  void selectCategory(String category) {
    emit(state.copyWith(activeCategory: category));
  }

  Future<void> removeFavorite(String id) async {
    // Optimistic UI update: remove from local state immediately
    final updatedFavorites = List<FavoriteItem>.from(state.favorites)
      ..removeWhere((element) => element.id == id);
      
    emit(state.copyWith(favorites: updatedFavorites));

    final result = await _favoriteRepository.removeFavorite(id);
    
    if (result is Failure) {
      // Revert in case of failure
      await getFavorites();
    }
  }

  Future<void> addFavorite(FavoriteItem item) async {
    final result = await _favoriteRepository.addFavorite(item);
    if (result is Success) {
      final updatedFavorites = List<FavoriteItem>.from(state.favorites);
      if (!updatedFavorites.any((element) => element.id == item.id)) {
        updatedFavorites.add(item);
        emit(state.copyWith(favorites: updatedFavorites));
      }
    }
  }
}
