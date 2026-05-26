import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/auth/domain/repository/base_auth_repository.dart';

class SigninUseCase extends BaseUseCase<Result, Map<String, dynamic>> {
  final BaseAuthRepository baseAuthRepository;
  SigninUseCase({required this.baseAuthRepository});

  @override
  Future<Result> call({required Map<String, dynamic> params}) async {
    return await baseAuthRepository.signin(body: params);
  }
}
