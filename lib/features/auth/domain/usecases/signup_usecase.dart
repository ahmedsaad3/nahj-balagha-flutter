import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/auth/domain/repository/base_auth_repository.dart';

class SignupUseCase extends BaseUseCase<Result, SignupParams> {
  final BaseAuthRepository baseAuthRepository;
  SignupUseCase({required this.baseAuthRepository});

  @override
  Future<Result> call({required SignupParams params}) async {
    return await baseAuthRepository.signup(params: params);
  }
}
