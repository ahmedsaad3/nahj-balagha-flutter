import 'package:nahj_balagha_flutter/features/favorites/data/datasource/base_favorite_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/favorites/domain/repository/base_favorite_repository.dart';

class FavoriteRepository implements BaseFavoriteRepository {
  final BaseFavoriteRemoteDataSource baseFavoriteRemoteDataSource;

  FavoriteRepository({required this.baseFavoriteRemoteDataSource});
}
