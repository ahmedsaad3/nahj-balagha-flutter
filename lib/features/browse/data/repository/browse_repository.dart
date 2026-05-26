import 'package:nahj_balagha_flutter/features/browse/data/datasource/base_browse_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/browse/domain/repository/base_browse_repository.dart';

class BrowseRepository implements BaseBrowseRepository {
  final BaseBrowseRemoteDataSource baseBrowseRemoteDataSource;

  BrowseRepository({required this.baseBrowseRemoteDataSource});
}
