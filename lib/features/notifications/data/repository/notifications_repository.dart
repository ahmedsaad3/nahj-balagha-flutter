import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/notifications/data/datasource/base_notifications_remote_data_source.dart';
import 'package:nahj_balagha_flutter/features/notifications/domain/repository/base_notifications_repository.dart';

class NotificationsRepository extends BaseNotificationsRepository {
  final BaseNotificationsRemoteDataSource baseNotificationsRemoteDataSource;

  NotificationsRepository({required this.baseNotificationsRemoteDataSource});

  @override
  Future<Result> getNotifications({required PaginationParams params}) async {
    return await baseNotificationsRemoteDataSource.getNotifications(
      params: params,
    );
  }

  @override
  Future<Result> getMailbox({required PaginationParams params}) async {
    return await baseNotificationsRemoteDataSource.getMailbox(params: params);
  }

  @override
  Future<Result> subscribeToTopic({required String topicId}) async {
    return await baseNotificationsRemoteDataSource.subscribeToTopic(
      topicId: topicId,
    );
  }

  @override
  Future<Result> unsubscribeFromTopic({required String topicId}) async {
    return await baseNotificationsRemoteDataSource.unsubscribeFromTopic(
      topicId: topicId,
    );
  }
}
