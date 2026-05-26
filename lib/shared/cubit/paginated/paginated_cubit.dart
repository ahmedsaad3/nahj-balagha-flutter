import 'package:async/async.dart' hide Result;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/shared/cubit/paginated/paginated_state.dart';
import 'package:nahj_balagha_flutter/shared/models/pagination.dart';

/// Generic base cubit for paginated data
/// [T] is the type of items in the paginated list
/// [S] is the state type that extends PaginatedState<T>
abstract class PaginatedCubit<T, S extends PaginatedState<T>> extends Cubit<S> {
  final int pageSize;
  final double scrollThreshold;

  ScrollController? _scrollController;
  CancelableOperation? _inflight;
  bool _isLoadingMore = false;

  PaginatedCubit({
    required S initialState,
    this.pageSize = 16,
    this.scrollThreshold = 0.9,
  }) : super(initialState);

  /// Initialize scroll controller and attach listener
  void initScrollController(ScrollController controller) {
    _scrollController = controller;
    _scrollController?.addListener(_onScroll);
  }

  /// Handle scroll events and trigger load more at threshold
  void _onScroll() {
    if (_scrollController == null || !_scrollController!.hasClients) return;

    // Check if there are multiple positions and handle safely
    final ScrollPosition position = _scrollController!.positions.length == 1
        ? _scrollController!.position
        : _scrollController!.positions.first;

    final maxScroll = position.maxScrollExtent;
    final currentScroll = position.pixels;
    final isBottom = currentScroll >= (maxScroll * scrollThreshold);
    if (isBottom) {
      loadMore();
    }
  }

  /// Abstract method for loading more data - must be implemented by subclasses
  Future<void> loadMore();

  /// Cancel any in-flight request
  void cancelInflight() {
    _inflight?.cancel();
    _inflight = null;
  }

  /// Create a cancelable operation from a future
  void setInflight(Future<Result> future) {
    _inflight = CancelableOperation.fromFuture(future);
  }

  /// Get the current in-flight operation result
  Future<Result?> getInflightResult() async {
    return await _inflight?.value;
  }

  /// Check if there's an in-flight request
  bool get hasInflight => _inflight != null;

  /// Helper to emit loading state
  void emitLoading() {
    if (isClosed) return;
    emit(state.copyWith(requestState: RequestState.loading) as S);
  }

  /// Helper to emit loaded state with initial data
  void emitLoaded(List<T> data, Pagination<Object?> pagination) {
    if (isClosed) return;
    _isLoadingMore = false;
    emit(
      state.copyWith(
            requestState: RequestState.loaded,
            data: data,
            currentPage: pagination.currentPage,
            totalPages: pagination.pagesCount,
            hasMorePages: pagination.hasNextPage,
            isLoadingMore: false,
          )
          as S,
    );
  }

  /// Helper to emit error state
  void emitError(String message) {
    if (isClosed) return;
    _isLoadingMore = false;
    emit(
      state.copyWith(
            requestState: RequestState.error,
            message: message,
            isLoadingMore: false,
          )
          as S,
    );
  }

  /// Helper to emit loading more state
  void emitLoadingMore() {
    if (isClosed) return;
    _isLoadingMore = true;
    emit(state.copyWith(isLoadingMore: true) as S);
  }

  /// Helper to reset loading more state
  void resetLoadingMore() {
    _isLoadingMore = false;
  }

  /// Helper to append data and update pagination
  void appendData(List<T> newData, Pagination<Object?> pagination) {
    if (isClosed) return;
    _isLoadingMore = false;
    emit(
      state.copyWith(
            data: [...state.data, ...newData],
            currentPage: pagination.currentPage,
            totalPages: pagination.pagesCount,
            hasMorePages: pagination.hasNextPage,
            isLoadingMore: false,
          )
          as S,
    );
  }

  /// Helper to check if should load more
  bool shouldLoadMore() {
    return !isClosed &&
        state.hasMorePages &&
        !_isLoadingMore &&
        state.requestState != RequestState.loading;
  }

  /// Dispose scroll controller
  void disposeScrollController() {
    _scrollController?.removeListener(_onScroll);
    _scrollController = null;
  }

  @override
  Future<void> close() {
    disposeScrollController();
    cancelInflight();
    return super.close();
  }
}
