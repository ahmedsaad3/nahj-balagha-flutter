import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
abstract class BaseBookRemoteDataSource {
  Future<Result> getBooks({required PaginationParams params});
}
