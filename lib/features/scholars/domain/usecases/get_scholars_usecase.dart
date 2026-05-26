import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/entities/scholar_entity.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/repository/base_scholar_repository.dart';

class GetScholarsUseCase
    implements BaseUseCase<Result<List<ScholarEntity>>, NoParameter> {
  final BaseScholarRepository baseScholarRepository;

  GetScholarsUseCase({required this.baseScholarRepository});

  @override
  Future<Result<List<ScholarEntity>>> call({NoParameter? params}) {
    return baseScholarRepository.getScholars();
  }
}
