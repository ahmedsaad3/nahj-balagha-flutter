import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/features/books/domain/entities/book_entity.dart';
import 'package:nahj_balagha_flutter/features/home/domain/entities/hikmah_entity.dart';

class HomeData extends Equatable {
  final HikmahEntity wisdomOfTheDay;
  final List<BookEntity> foreignStudies;
  final List<BookEntity> articles;

  const HomeData({
    required this.wisdomOfTheDay,
    required this.foreignStudies,
    required this.articles,
  });

  @override
  List<Object?> get props => [wisdomOfTheDay, foreignStudies, articles];
}
