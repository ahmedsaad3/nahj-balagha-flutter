import 'package:nahj_balagha_flutter/core/network/api_network.dart';
import 'package:nahj_balagha_flutter/core/network/dio_client.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/features/home/data/datasource/base_home_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/home/data/models/hikmah_model.dart';

class HomeRemoteDataSource implements BaseHomeRemoteDataSource {
  final DioClient _client;

  HomeRemoteDataSource({required DioClient client}) : _client = client;

  @override
  Future<Result> getHikmahToday() async {
    return _client.getRequest(
      url: ApiNetwork.GET_HIKMAH_TODAY_ENDPOINT,
      converter: (response) {
        return HikmahModel.fromJson(response);
      },
    );
  }
}
