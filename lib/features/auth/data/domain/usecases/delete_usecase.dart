import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/auth/data/domain/repository/base_auth_repository.dart';

class DeleteUseCase extends BaseUseCase<Result, int> {
  final BaseAuthRepository baseAuthRepository;
  DeleteUseCase({required this.baseAuthRepository});

  @override
  Future<Result> call({required int params}) async {
    return await baseAuthRepository.delete();
  }
}
