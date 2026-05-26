import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/books/domain/entities/book_entity.dart';
import 'package:nahj_balagha_flutter/features/books/domain/repository/base_book_repository.dart';

class GetForeignStudiesUseCases
    implements BaseUseCase<Result<List<BookEntity>>, NoParameter> {
  final BaseBookRepository baseBookRepository;

  GetForeignStudiesUseCases({required this.baseBookRepository});

  @override
  Future<Result<List<BookEntity>>> call({NoParameter? params}) async {
    return await baseBookRepository.getForeignStudies();
  }
}
