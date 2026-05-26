import 'package:nahj_balagha_flutter/features/search/data/datasource/base_search_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/search/domain/repository/base_search_repository.dart';

class SearchRepository implements BaseSearchRepository {
  final BaseSearchRemoteDataSource baseSearchRemoteDataSource;

  SearchRepository({required this.baseSearchRemoteDataSource});
}
