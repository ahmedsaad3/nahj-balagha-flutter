import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';

abstract class BaseAuthRemoteDataSource {
  Future<Result> signin({required Map<String, dynamic> body});
  Future<Result> signup({required SignupParams params});
  Future<Result> update({required UpdateUserInfoParams params});
  Future<Result> delete();
}
