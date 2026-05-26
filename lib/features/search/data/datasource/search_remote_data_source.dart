import 'package:nahj_balagha_flutter/core/network/dio_client.dart';
import 'package:nahj_balagha_flutter/features/search/data/datasource/base_search_remote_data_source.dart';

class SearchRemoteDataSource implements BaseSearchRemoteDataSource {
  final DioClient _client;

  SearchRemoteDataSource({required DioClient client}) : _client = client;
}
