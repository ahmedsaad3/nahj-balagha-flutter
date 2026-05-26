import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/settings/data/datasource/base_settings_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/settings/domain/repository/base_settings_repository.dart';

class SettingsRepository extends BaseSettingsRepository {
  final BaseSettingsRemoteDataSource baseSettingsRemoteDataSource;

  SettingsRepository({required this.baseSettingsRemoteDataSource});

  @override
  Future<Result> getFAQs({NoParameter? params}) {
    return baseSettingsRemoteDataSource.getFAQs();
  }
}
