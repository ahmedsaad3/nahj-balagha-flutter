import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/books/data/datasource/base_book_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/books/domain/repository/base_book_repository.dart';

class BookRepository implements BaseBookRepository {
  final BaseBookRemoteDataSource baseBookRemoteDataSource;

  BookRepository({required this.baseBookRemoteDataSource});

  @override
  Future<Result> getBooks({required PaginationParams params}) {
    return baseBookRemoteDataSource.getBooks(params: params);
  }
}
