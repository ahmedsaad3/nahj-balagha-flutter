import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/auth/data/datasource/base_auth_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/auth/data/domain/repository/base_auth_repository.dart';

class AuthRepository extends BaseAuthRepository {
  final BaseAuthRemoteDataSource baseAuthRemoteDataSource;

  AuthRepository({required this.baseAuthRemoteDataSource});
  @override
  Future<Result> delete() async {
    return baseAuthRemoteDataSource.delete();
  }

  @override
  Future<Result> signin({required Map<String, dynamic> body}) {
    return baseAuthRemoteDataSource.signin(body: body);
  }

  @override
  Future<Result> signup({required SignupParams params}) {
    return baseAuthRemoteDataSource.signup(params: params);
  }

  @override
  Future<Result> update({required UpdateUserInfoParams params}) {
    return baseAuthRemoteDataSource.update(params: params);
  }
}
