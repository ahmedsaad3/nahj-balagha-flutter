import 'package:nahj_balagha_flutter/core/network/dio_client.dart';
import 'package:nahj_balagha_flutter/features/profile/data/datasource/base_profile_remote_data_source.dart';

class ProfileRemoteDataSource implements BaseProfileRemoteDataSource {
  final DioClient _client;

  ProfileRemoteDataSource({required DioClient client}) : _client = client;

}
