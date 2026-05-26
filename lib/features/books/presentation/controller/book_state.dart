import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/books/domain/entities/book_entity.dart';

class BookState extends Equatable {
  final RequestState foreignStudiesState;
  final List<BookEntity> foreignStudies;
  final String foreignStudiesMessage;
  final RequestState articlesState;
  final List<BookEntity> articles;
  final String articlesMessage;
  const BookState({
    this.foreignStudiesState = RequestState.loading,
    this.foreignStudies = const [],
    this.foreignStudiesMessage = '',
    this.articlesState = RequestState.loading,
    this.articles = const [],
    this.articlesMessage = '',
  });

  BookState copyWith({
    RequestState? foreignStudiesState,
    List<BookEntity>? foreignStudies,
    String? foreignStudiesMessage,
    RequestState? articlesState,
    List<BookEntity>? articles,
    String? articlesMessage,
  }) {
    return BookState(
      foreignStudiesState: foreignStudiesState ?? this.foreignStudiesState,
      foreignStudies: foreignStudies ?? this.foreignStudies,
      foreignStudiesMessage: foreignStudiesMessage ?? this.foreignStudiesMessage,
      articlesState: articlesState ?? this.articlesState,
      articles: articles ?? this.articles,
      articlesMessage: articlesMessage ?? this.articlesMessage,
    );
  }

  @override
  List<Object?> get props => [
    foreignStudiesState,
    foreignStudies,
    foreignStudiesMessage,
    articlesState,
    articles,
    articlesMessage,
  ];
}
