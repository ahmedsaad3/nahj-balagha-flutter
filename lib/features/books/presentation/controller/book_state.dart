import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/books/domain/entities/book_entity.dart';
import 'package:nahj_balagha_flutter/shared/cubit/paginated/paginated_state.dart';

class BookState extends PaginatedState<BookEntity> {
  const BookState({
    List<BookEntity> books = const [],
    super.requestState = RequestState.idle,
    super.message = '',
    super.currentPage = 1,
    super.totalPages = 1,
    super.hasMorePages = false,
    super.isLoadingMore = false,
  }) : super(data: books);

  List<BookEntity> get books => data;

  @override
  BookState copyWith({
    RequestState? requestState,
    List<BookEntity>? data,
    String? message,
    int? currentPage,
    int? totalPages,
    bool? hasMorePages,
    bool? isLoadingMore,
  }) {
    return BookState(
      requestState: requestState ?? this.requestState,
      books: data ?? this.data,
      message: message ?? this.message,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasMorePages: hasMorePages ?? this.hasMorePages,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

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
}
