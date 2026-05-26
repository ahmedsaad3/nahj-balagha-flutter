import 'package:nahj_balagha_flutter/core/network/api_network.dart';
import 'package:nahj_balagha_flutter/core/network/dio_client.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/notifications/data/model/notification_model.dart';
import 'package:nahj_balagha_flutter/shared/models/pagination_model.dart';

import 'base_notifications_remote_data_source.dart';

class NotificationsRemoteDataSource extends BaseNotificationsRemoteDataSource {
  final DioClient _client;
  // final FirebaseNotificationService _firebaseNotificationService;

  NotificationsRemoteDataSource({required DioClient client}) : _client = client;
  //  _firebaseNotificationService = firebaseNotificationService;

  @override
  Future<Result> getNotifications({required PaginationParams params}) async {
    final response = await _client.getRequest(
      url: ApiNetwork.NOTIFICATIONS_ENDPOINT,
      isAuth: true,
      queryParameters: params.toJson(),
      converter: (response) {
        return PaginationModel.fromJson(
          response,
          (json) => NotificationModel.fromJson(json),
        );
      },
    );
    return response;
  }

  @override
  Future<Result> getMailbox({required PaginationParams params}) async {
    final response = await _client.getRequest(
      url: ApiNetwork.MAILBOX_ENDPOINT,
      isAuth: true,
      queryParameters: params.toJson(),
      converter: (response) {
        return PaginationModel.fromJson(
          response,
          (json) => NotificationModel.fromJson(json),
        );
      },
    );
    return response;
  }

  @override
  Future<Result> subscribeToTopic({required String topicId}) async {
    // try {
    //   // Subscribe to topic via Firebase
    //   final result = await _firebaseNotificationService.subscribeToTopic(
    //     topicId,
    //   );

    //   if (result == true) {
    //     return const Success();
    //   }
    //   return const Failure(code: 400, response: 'Failed to subscribe to topic');
    // } catch (e) {
    //   return Failure(code: 500, response: e.toString());
    // }
    return const Success();
  }

  @override
  Future<Result> unsubscribeFromTopic({required String topicId}) async {
    // try {
    //   // Unsubscribe from topic via Firebase
    //   final result = await _firebaseNotificationService.unsubscribeFromTopic(
    //     topicId,
    //   );
    //   if (result == true) {
    //     return const Success();
    //   }
    //   return const Failure(
    //     code: 400,
    //     response: 'Failed to unsubscribe from topic',
    //   );
    // } catch (e) {
    //   return Failure(code: 500, response: e.toString());
    // }
    return const Success();
  }
}
