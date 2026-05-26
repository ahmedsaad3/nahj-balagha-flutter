import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/features/books/data/datasource/base_book_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/books/domain/entities/book_entity.dart';
import 'package:nahj_balagha_flutter/features/books/domain/repository/base_book_repository.dart';

class BookRepository implements BaseBookRepository {
  final BaseBookRemoteDataSource baseBookRemoteDataSource;

  BookRepository({required this.baseBookRemoteDataSource});

  @override
  Future<Result<List<BookEntity>>> getForeignStudies() {
    return baseBookRemoteDataSource.getForeignStudies();
  }

  @override
  Future<Result<List<BookEntity>>> getArticles() {
    return baseBookRemoteDataSource.getArticles();
  }
}
