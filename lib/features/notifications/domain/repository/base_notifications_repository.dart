import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';

abstract class BaseNotificationsRepository {
  Future<Result> getNotifications({required PaginationParams params});
  Future<Result> getMailbox({required PaginationParams params});
  Future<Result> subscribeToTopic({required String topicId});
  Future<Result> unsubscribeFromTopic({required String topicId});
}
