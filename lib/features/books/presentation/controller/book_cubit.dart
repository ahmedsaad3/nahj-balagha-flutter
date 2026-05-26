import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/books/domain/usecases/get_articles_usecases.dart';
import 'package:nahj_balagha_flutter/features/books/domain/usecases/get_foreign_studies_usecases.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/features/books/presentation/controller/book_state.dart';

class BookCubit extends Cubit<BookState> {
  final GetForeignStudiesUseCases getForeignStudiesUseCases;
  final GetArticlesUseCases getArticlesUseCases;

  BookCubit({
    required this.getArticlesUseCases,
    required this.getForeignStudiesUseCases,
  }) : super(const BookState());

  Future<void> getArticles() async {
    emit(
      state.copyWith(
        articlesState: RequestState.loading,
        articlesMessage: '',
        articles: [],
      ),
    );
    final result = await getArticlesUseCases();
    switch (result) {
      case Success(response: final response):
        emit(
          state.copyWith(
            articlesState: RequestState.loaded,
            articles: response,
            articlesMessage: '',
          ),
        );
      case Failure():
        emit(
          state.copyWith(
            articlesState: RequestState.error,
            articlesMessage: 'حدث خطأ',
            articles: [],
          ),
        );
    }
  }

  Future<void> getForeignStudies() async {
    emit(
      state.copyWith(
        foreignStudiesState: RequestState.loading,
        foreignStudiesMessage: '',
        foreignStudies: [],
      ),
    );
    final result = await getForeignStudiesUseCases();
    switch (result) {
      case Success(response: final response):
        emit(
          state.copyWith(
            foreignStudiesState: RequestState.loaded,
            foreignStudies: response,
            foreignStudiesMessage: '',
          ),
        );
      case Failure():
        emit(
          state.copyWith(
            foreignStudiesState: RequestState.error,
            foreignStudiesMessage: 'حدث خطأ',
            foreignStudies: [],
          ),
        );
    }
  }
}
