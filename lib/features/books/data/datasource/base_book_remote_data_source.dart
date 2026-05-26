import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/features/books/data/model/book.dart';

abstract class BaseBookRemoteDataSource {
  Future<Result<List<BookModel>>> getForeignStudies();
  Future<Result<List<BookModel>>> getArticles();
}
