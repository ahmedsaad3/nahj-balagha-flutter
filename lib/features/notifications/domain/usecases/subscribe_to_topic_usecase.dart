import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/notifications/domain/repository/base_notifications_repository.dart';

class SubscribeToTopicUseCase extends BaseUseCase<Result, TopicIdParams> {
  final BaseNotificationsRepository baseNotificationsRepository;

  SubscribeToTopicUseCase({required this.baseNotificationsRepository});

  @override
  Future<Result> call({required TopicIdParams params}) async {
    return await baseNotificationsRepository.subscribeToTopic(
      topicId: params.topicId,
    );
  }
}
