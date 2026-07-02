import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/home/domain/repository/base_home_repository.dart';

class GetHikmahTodayUseCase implements BaseUseCase<Result, NoParameter> {
  final BaseHomeRepository baseHomeRepository;

  GetHikmahTodayUseCase({required this.baseHomeRepository});

  @override
  Future<Result> call({NoParameter? params}) {
    return baseHomeRepository.getHikmahToday();
  }
}
