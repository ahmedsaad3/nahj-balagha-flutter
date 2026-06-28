import 'package:nahj_balagha_flutter/core/network/result.dart';

abstract class BaseHomeRepository {
  Future<Result> getHikmahToday();
}
