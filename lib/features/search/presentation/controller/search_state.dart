import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/search/domain/entities/search_result_entity.dart';

class SearchState extends Equatable {
  final RequestState searchState;
  final List<SearchResultEntity> results;
  final String searchQuery;
  final String activeFilter;
  final String activeScope;
  final String errorMessage;

  const SearchState({
    this.searchState = RequestState.idle,
    this.results = const [],
    this.searchQuery = '',
    this.activeFilter = 'الكل',
    this.activeScope = 'الكل',
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [
        searchState,
        results,
        searchQuery,
        activeFilter,
        activeScope,
        errorMessage,
      ];

  SearchState copyWith({
    RequestState? searchState,
    List<SearchResultEntity>? results,
    String? searchQuery,
    String? activeFilter,
    String? activeScope,
    String? errorMessage,
  }) {
    return SearchState(
      searchState: searchState ?? this.searchState,
      results: results ?? this.results,
      searchQuery: searchQuery ?? this.searchQuery,
      activeFilter: activeFilter ?? this.activeFilter,
      activeScope: activeScope ?? this.activeScope,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
