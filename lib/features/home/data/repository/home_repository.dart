import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/features/home/data/datasource/base_home_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/home/domain/repository/base_home_repository.dart';

class HomeRepository implements BaseHomeRepository {
  final BaseHomeRemoteDataSource baseHomeRemoteDataSource;

  HomeRepository({required this.baseHomeRemoteDataSource});

  @override
  Future<Result> getHikmahToday() {
    return baseHomeRemoteDataSource.getHikmahToday();
  }
}
