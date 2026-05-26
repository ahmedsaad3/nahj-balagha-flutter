import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/features/books/domain/entities/book_entity.dart';

abstract class BaseBookRepository {
  Future<Result<List<BookEntity>>> getForeignStudies();
  Future<Result<List<BookEntity>>> getArticles();
}
