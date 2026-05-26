import 'package:nahj_balagha_flutter/core/network/dio_client.dart';
import 'package:nahj_balagha_flutter/features/browse/data/datasource/base_browse_remote_data_source.dart';

class BrowseRemoteDataSource implements BaseBrowseRemoteDataSource {
  final DioClient _client;

  BrowseRemoteDataSource({required DioClient client}) : _client = client;
}
