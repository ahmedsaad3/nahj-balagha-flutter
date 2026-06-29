import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/books/domain/entities/book_entity.dart';
import 'package:nahj_balagha_flutter/features/books/domain/usecases/get_books_usecase.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/features/books/presentation/controller/book_state.dart';
import 'package:nahj_balagha_flutter/shared/cubit/paginated/paginated_cubit.dart';
import 'package:nahj_balagha_flutter/shared/models/pagination.dart';

class BookCubit extends PaginatedCubit<BookEntity, BookState> {
  final GetBooksUseCase getBooksUseCases;

  BookCubit({required this.getBooksUseCases})
    : super(initialState: const BookState());

  Future<void> getBooks() async {
    emitLoading();

    final params = PaginationParams(pageNumber: 1, pageSize: pageSize);
    final result = await getBooksUseCases(params: params);

    if (result is Success) {
      final pagination = result.response as Pagination<BookEntity>;
      emitLoaded(pagination.data, pagination);
      return;
    }

    if (result is Failure) {
      emitError(result.response);
      return;
    }
  }

  @override
  Future<void> loadMore() async {
    if (!shouldLoadMore()) {
      return;
    }

    emitLoadingMore();

    final nextPage = state.currentPage + 1;
    final params = PaginationParams(pageNumber: nextPage, pageSize: pageSize);

    final result = await getBooksUseCases(params: params);

    if (result is Success) {
      final pagination = result.response as Pagination<BookEntity>;
      appendData(pagination.data, pagination);
      return;
    }

    if (result is Failure) {
      resetLoadingMore();
      emit(
        state.copyWith(
          isLoadingMore: false,
          hasMorePages: false,
          message: result.response,
        ),
      );
      return;
    }
  }
}
