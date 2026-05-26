import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';

abstract class BaseSettingsRepository {
  Future<Result> getFAQs({NoParameter? params});
}
