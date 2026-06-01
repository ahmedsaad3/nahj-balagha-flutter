import 'package:nahj_balagha_flutter/features/content/data/datasource/base_content_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/content/domain/repository/base_content_repository.dart';


class ContentRepository implements BaseContentRepository {
  final BaseContentRemoteDataSource baseContentRemoteDataSource;

  ContentRepository({required this.baseContentRemoteDataSource});
}
