import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/features/search/domain/entities/search_result_entity.dart';

abstract class BaseSearchRepository {
  Future<Result<List<SearchResultEntity>>> search({
    required String query,
    required String filter,
    required String scope,
  });
}
