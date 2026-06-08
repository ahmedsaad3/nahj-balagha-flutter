import 'package:nahj_balagha_flutter/core/network/result.dart';

abstract class BaseSearchRemoteDataSource {
  Future<Result> search({
    required String query,
    required String filter,
    required String scope,
  });
}
