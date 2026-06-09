import 'package:nahj_balagha_flutter/features/favorites/data/model/favorite_item_model.dart';

abstract class BaseFavoriteRemoteDataSource {
  Future<List<FavoriteItemModel>> getFavorites();
  Future<void> addFavorite(FavoriteItemModel item);
  Future<void> removeFavorite(String id);
}

