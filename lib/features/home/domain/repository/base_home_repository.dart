import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/features/home/domain/entities/home_data.dart';

abstract class BaseHomeRepository {
  Future<Result<HomeData>> getHomeData();
}
