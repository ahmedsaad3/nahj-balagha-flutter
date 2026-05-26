import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/features/scholars/data/model/scholar.dart';

abstract class BaseScholarRemoteDataSource {
  Future<Result<List<ScholarModel>>> getScholars();
}
