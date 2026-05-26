import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/settings/domain/repository/base_settings_repository.dart';

class GetFAQsUseCase implements BaseUseCase<Result, NoParameter> {
  final BaseSettingsRepository baseSettingsRepository;

  GetFAQsUseCase({required this.baseSettingsRepository});

  @override
  Future<Result> call({NoParameter? params}) {
    return baseSettingsRepository.getFAQs(params: params);
  }
}
