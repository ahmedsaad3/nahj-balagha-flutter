import 'package:nahj_balagha_flutter/core/network/result.dart';

abstract class BaseSettingsRemoteDataSource {
  Future<Result> getFAQs();
}
