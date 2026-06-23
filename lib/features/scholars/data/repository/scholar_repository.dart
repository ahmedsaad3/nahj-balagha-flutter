import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/repository/base_scholar_repository.dart';
import 'package:nahj_balagha_flutter/features/scholars/data/datasource/base_scholar_remote_data_source.dart';

class ScholarRepository implements BaseScholarRepository {
  final BaseScholarRemoteDataSource baseScholarRemoteDataSource;

  ScholarRepository({required this.baseScholarRemoteDataSource});

  @override
  Future<Result> getScholars({
    required ScholarParams params,
  }) async {
    return await baseScholarRemoteDataSource.getScholars(params: params);
  }
}
