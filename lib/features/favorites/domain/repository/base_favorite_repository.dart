import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/features/favorites/domain/entities/favorite_item.dart';

abstract class BaseFavoriteRepository {
  Future<Result<List<FavoriteItem>>> getFavorites();
  Future<Result<void>> addFavorite(FavoriteItem item);
  Future<Result<void>> removeFavorite(String id);
}

