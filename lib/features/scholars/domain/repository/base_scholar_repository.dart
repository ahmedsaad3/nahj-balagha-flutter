import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/entities/scholar_entity.dart';

abstract class BaseScholarRepository {
  Future<Result<List<ScholarEntity>>> getScholars();
}
