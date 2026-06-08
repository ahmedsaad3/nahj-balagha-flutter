import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/features/search/data/datasource/base_search_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/search/domain/entities/search_result_entity.dart';
import 'package:nahj_balagha_flutter/features/search/domain/repository/base_search_repository.dart';

class SearchRepository implements BaseSearchRepository {
  final BaseSearchRemoteDataSource baseSearchRemoteDataSource;

  SearchRepository({required this.baseSearchRemoteDataSource});

  @override
  Future<Result<List<SearchResultEntity>>> search({
    required String query,
    required String filter,
    required String scope,
  }) async {
    final result = await baseSearchRemoteDataSource.search(
      query: query,
      filter: filter,
      scope: scope,
    );

    if (result is Success) {
      final List<SearchResultEntity> results = (result.response as List).cast<SearchResultEntity>();
      return Success(code: result.code, response: results);
    } else {
      return Failure(code: result.code, response: result.response);
    }
  }
}
