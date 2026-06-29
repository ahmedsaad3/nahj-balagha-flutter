import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/network/error_message_model.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/books/domain/entities/book_entity.dart';
import 'package:nahj_balagha_flutter/features/books/domain/usecases/get_books_usecase.dart';
import 'package:nahj_balagha_flutter/features/home/domain/entities/hikmah_entity.dart';
import 'package:nahj_balagha_flutter/features/home/domain/usecases/get_hikmah_data_usecase.dart';
import 'package:nahj_balagha_flutter/features/home/presentation/controller/home_state.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/entities/scholar_entity.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/usecases/get_scholars_usecase.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHikmahDataUseCase _getHikmahDataUseCase;
  final GetScholarsUseCase _getScholarsUseCase;
  final GetBooksUseCase _getBooksUseCase;

  List<ScholarEntity> _scholars = [];
  HikmahEntity? _hikmah;
  List<BookEntity> _books = [];

  HomeCubit({
    required GetHikmahDataUseCase getHikmahDataUseCase,
    required GetScholarsUseCase getScholarsUseCase,
    required GetBooksUseCase getBooksUseCase,
  }) : _getHikmahDataUseCase = getHikmahDataUseCase,
       _getScholarsUseCase = getScholarsUseCase,
       _getBooksUseCase = getBooksUseCase,
       super(const HomeState());

  Future<void> loadHomeData() async {
    await Future.wait([fetchScholars(), fetchHikmahToday(), fetchBooks()]);
  }

  Future<void> fetchHikmahToday() async {
    if (isClosed) return;

    emit(state.copyWith(hikmahState: RequestState.loading));
    // Return cached categories if available
    if (_hikmah != null) {
      emit(state.copyWith(hikmahState: RequestState.loaded, hikmah: _hikmah));
      return;
    }

    final Result result = await _getHikmahDataUseCase();

    if (result.response == null || isClosed) return;

    if (result is Success) {
      _hikmah = result.response;
      emit(state.copyWith(hikmahState: RequestState.loaded, hikmah: _hikmah));
    } else if (result is Failure) {
      ErrorMessageModel errorMessage = result.response;
      emit(
        state.copyWith(
          hikmahState: RequestState.error,
          hikmahErrorMessage: errorMessage.message,
        ),
      );
    }
  }

  Future<void> fetchScholars() async {
    if (isClosed) return;

    emit(state.copyWith(scholarsState: RequestState.loading));
    // Return cached categories if available
    if (_scholars.isNotEmpty) {
      emit(
        state.copyWith(scholarsState: RequestState.loaded, scholars: _scholars),
      );
      return;
    }

    final Result result = await _getScholarsUseCase(
      params: ScholarParams(
        pageNumber: 1,
        pageSize: 8,
        personTypeId: '1e9ca45c-0118-47c3-8eb1-e2307bdc526d',
      ),
    );

    if (result.response == null || isClosed) return;

    if (result is Success) {
      _scholars = result.response.data;
      emit(
        state.copyWith(scholarsState: RequestState.loaded, scholars: _scholars),
      );
    } else if (result is Failure) {
      ErrorMessageModel errorMessage = result.response;
      emit(
        state.copyWith(
          scholarsState: RequestState.error,
          scholarErrorMessage: errorMessage.message,
        ),
      );
    }
  }

  Future<void> fetchBooks() async {
    if (isClosed) return;

    emit(state.copyWith(booksState: RequestState.loading));

    if (_books.isNotEmpty) {
      emit(state.copyWith(booksState: RequestState.loaded, books: _books));
      return;
    }

    final Result result = await _getBooksUseCase(
      params: PaginationParams(pageNumber: 1, pageSize: 8),
    );

    if (result.response == null || isClosed) return;

    if (result is Success) {
      _books = result.response.data;
      emit(state.copyWith(booksState: RequestState.loaded, books: _books));
    } else if (result is Failure) {
      ErrorMessageModel errorMessage = result.response;
      emit(
        state.copyWith(
          booksState: RequestState.error,
          bookErrorMessage: errorMessage.message,
        ),
      );
    }
  }
}
