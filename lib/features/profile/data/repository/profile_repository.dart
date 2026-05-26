import 'package:nahj_balagha_flutter/features/profile/data/datasource/base_profile_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/profile/domain/repository/base_profile_repository.dart';

class ProfileRepository implements BaseProfileRepository {
  final BaseProfileRemoteDataSource baseProfileRemoteDataSource;

  ProfileRepository({required this.baseProfileRemoteDataSource});
}
