import 'package:nahj_balagha_flutter/core/network/dio_client.dart';
import 'package:nahj_balagha_flutter/features/favorites/data/datasource/base_favorite_remote_data_source.dart';

class FavoriteRemoteDataSource implements BaseFavoriteRemoteDataSource {
  final DioClient _client;

  FavoriteRemoteDataSource({required DioClient client}) : _client = client;
}
