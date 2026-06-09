import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/features/favorites/data/datasource/base_favorite_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/favorites/data/model/favorite_item_model.dart';
import 'package:nahj_balagha_flutter/features/favorites/domain/entities/favorite_item.dart';
import 'package:nahj_balagha_flutter/features/favorites/domain/repository/base_favorite_repository.dart';

class FavoriteRepository implements BaseFavoriteRepository {
  final BaseFavoriteRemoteDataSource baseFavoriteRemoteDataSource;

  FavoriteRepository({required this.baseFavoriteRemoteDataSource});

  @override
  Future<Result<List<FavoriteItem>>> getFavorites() async {
    try {
      final List<FavoriteItemModel> response = await baseFavoriteRemoteDataSource.getFavorites();
      return Success(code: 200, response: response);
    } catch (e) {
      return Failure(code: 500, response: e.toString() as dynamic);
    }
  }

  @override
  Future<Result<void>> addFavorite(FavoriteItem item) async {
    try {
      final model = FavoriteItemModel(
        id: item.id,
        title: item.title,
        description: item.description,
        category: item.category,
        url: item.url,
        hasAudio: item.hasAudio,
      );
      await baseFavoriteRemoteDataSource.addFavorite(model);
      return const Success(code: 200, response: null);
    } catch (e) {
      return const Failure(code: 500, response: null);
    }
  }

  @override
  Future<Result<void>> removeFavorite(String id) async {
    try {
      await baseFavoriteRemoteDataSource.removeFavorite(id);
      return const Success(code: 200, response: null);
    } catch (e) {
      return const Failure(code: 500, response: null);
    }
  }
}
