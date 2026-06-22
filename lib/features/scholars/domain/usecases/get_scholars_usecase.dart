import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/repository/base_scholar_repository.dart';

class GetScholarsUseCase
    extends BaseUseCase<Result, PaginationParams> {
  final BaseScholarRepository _baseScholarRepository;

  GetScholarsUseCase({required BaseScholarRepository baseScholarRepository})
    : _baseScholarRepository = baseScholarRepository;

  @override
  Future<Result> call({required PaginationParams params}) {
    return _baseScholarRepository.getScholars(params: params);
  }
}
