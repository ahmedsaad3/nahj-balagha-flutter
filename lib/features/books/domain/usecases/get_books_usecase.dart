import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/books/domain/repository/base_book_repository.dart';

class GetBooksUseCase implements BaseUseCase<Result, PaginationParams> {
  final BaseBookRepository baseBookRepository;

  GetBooksUseCase({required this.baseBookRepository});

  @override
  Future<Result> call({required PaginationParams params}) async {
    return await baseBookRepository.getBooks(params: params);
  }
}
