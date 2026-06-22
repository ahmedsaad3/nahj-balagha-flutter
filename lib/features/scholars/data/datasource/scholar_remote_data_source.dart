import 'package:nahj_balagha_flutter/core/network/api_network.dart';
import 'package:nahj_balagha_flutter/core/network/dio_client.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/scholars/data/model/scholar_model.dart';
import 'package:nahj_balagha_flutter/shared/models/pagination_model.dart';
import 'base_scholar_remote_data_source.dart';

class ScholarRemoteDataSource implements BaseScholarRemoteDataSource {
  final DioClient _client;

  ScholarRemoteDataSource({required DioClient client}) : _client = client;
  @override
  Future<Result> getScholars({required PaginationParams params}) async {
    return _client.getRequest(
      url: ApiNetwork.GET_SCHOLARS,
      isAuth: true,
      queryParameters: params.toJson(),
      converter: (response) {
        return PaginationModel.fromJson(
          response,
          (json) => ScholarModel.fromJson(json),
        );
      },
    );
  }
}
