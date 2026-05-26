import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';

/// Generic base state for paginated data
///
/// [T] is the type of items in the paginated list
abstract class PaginatedState<T> extends Equatable {
  final RequestState requestState;
  final List<T> data;
  final String message;
  final int currentPage;
  final int totalPages;
  final bool hasMorePages;
  final bool isLoadingMore;

  const PaginatedState({
    required this.requestState,
    required this.data,
    required this.message,
    required this.currentPage,
    required this.totalPages,
    required this.hasMorePages,
    required this.isLoadingMore,
  });

  @override
  List<Object?> get props => [
    requestState,
    data,
    message,
    currentPage,
    totalPages,
    hasMorePages,
    isLoadingMore,
  ];

  /// Subclasses must implement copyWith to maintain their specific type
  PaginatedState<T> copyWith({
    RequestState? requestState,
    List<T>? data,
    String? message,
    int? currentPage,
    int? totalPages,
    bool? hasMorePages,
    bool? isLoadingMore,
  });
}
