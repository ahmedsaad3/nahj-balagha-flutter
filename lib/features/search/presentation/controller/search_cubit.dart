// ignore_for_file: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/search/domain/usecases/search_usecase.dart';
import 'package:nahj_balagha_flutter/features/search/presentation/controller/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchUseCase _searchUseCase;

  SearchCubit({required SearchUseCase searchUseCase})
      : _searchUseCase = searchUseCase,
        super(const SearchState());

  CancelableOperation? _inflight;

  void updateSearchQuery(String query) {
    if (isClosed) return;
    emit(state.copyWith(searchQuery: query));
    performSearch();
  }

  void updateFilter(String filter) {
    if (isClosed) return;
    emit(state.copyWith(activeFilter: filter));
    performSearch();
  }

  void updateScope(String scope) {
    if (isClosed) return;
    emit(state.copyWith(activeScope: scope));
    performSearch();
  }

  Future<void> performSearch() async {
    if (isClosed) return;

    emit(state.copyWith(searchState: RequestState.loading));
    _inflight?.cancel();

    _inflight = CancelableOperation.fromFuture(
      _searchUseCase(
        params: SearchParams(
          query: state.searchQuery,
          filter: state.activeFilter,
          scope: state.activeScope,
        ),
      ),
    );

    final result = await _inflight?.value;

    if (isClosed) return;

    if (result == null) {
      // Operation was cancelled
      return;
    }

    if (result is Success) {
      emit(state.copyWith(
        searchState: RequestState.loaded,
        results: result.response,
      ));
    } else {
      emit(state.copyWith(
        searchState: RequestState.error,
        errorMessage: result.response?.toString() ?? 'حدث خطأ ما أثناء البحث',
      ));
    }
  }

  void clearSearch() {
    if (isClosed) return;
    emit(state.copyWith(
      searchQuery: '',
      results: const [],
      searchState: RequestState.idle,
    ));
  }

  @override
  Future<void> close() {
    _inflight?.cancel();
    return super.close();
  }
}
