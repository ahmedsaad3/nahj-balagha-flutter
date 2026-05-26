import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/features/books/domain/entities/book_entity.dart';
import 'package:nahj_balagha_flutter/features/home/domain/entities/wisdom_entity.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/entities/Scholar_entity.dart';

class HomeData extends Equatable {
  final WisdomEntity wisdomOfTheDay;
  final List<BookEntity> foreignStudies;
  final List<BookEntity> articles;
  final List<ScholarEntity> scholars;

  const HomeData({
    required this.wisdomOfTheDay,
    required this.foreignStudies,
    required this.articles,
    required this.scholars,
  });

  @override
  List<Object?> get props => [
    wisdomOfTheDay,
    foreignStudies,
    articles,
    scholars,
  ];
}
