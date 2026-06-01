import 'package:nahj_balagha_flutter/core/network/dio_client.dart';
import 'package:nahj_balagha_flutter/features/content/data/datasource/base_content_remote_data_source.dart';

class ContentRemoteDataSource implements BaseContentRemoteDataSource {
  final DioClient client;

  ContentRemoteDataSource({required this.client});
}
