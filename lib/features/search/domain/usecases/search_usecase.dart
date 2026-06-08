import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/search/domain/entities/search_result_entity.dart';
import 'package:nahj_balagha_flutter/features/search/domain/repository/base_search_repository.dart';

class SearchParams extends Equatable {
  final String query;
  final String filter;
  final String scope;

  const SearchParams({
    required this.query,
    required this.filter,
    required this.scope,
  });

  @override
  List<Object?> get props => [query, filter, scope];
}

class SearchUseCase implements BaseUseCase<Result<List<SearchResultEntity>>, SearchParams> {
  final BaseSearchRepository baseSearchRepository;

  SearchUseCase({required this.baseSearchRepository});

  @override
  Future<Result<List<SearchResultEntity>>> call({required SearchParams params}) {
    return baseSearchRepository.search(
      query: params.query,
      filter: params.filter,
      scope: params.scope,
    );
  }
}
