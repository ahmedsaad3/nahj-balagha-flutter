import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/auth/data/domain/repository/base_auth_repository.dart';

class UpdateUseCase extends BaseUseCase<Result, UpdateUserInfoParams> {
  final BaseAuthRepository baseAuthRepository;
  UpdateUseCase({required this.baseAuthRepository});

  @override
  Future<Result> call({required UpdateUserInfoParams params}) async {
    return await baseAuthRepository.update(params: params);
  }
}
