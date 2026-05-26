import 'package:nahj_balagha_flutter/core/network/error_message_model.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/notifications/domain/entities/notification.dart';
import 'package:nahj_balagha_flutter/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:nahj_balagha_flutter/features/notifications/domain/usecases/subscribe_to_topic_usecase.dart';
import 'package:nahj_balagha_flutter/features/notifications/domain/usecases/unsubscribe_from_topic_usecase.dart';
import 'package:nahj_balagha_flutter/features/notifications/presentation/controller/notifications/notifications_state.dart';
import 'package:nahj_balagha_flutter/shared/cubit/paginated/paginated_cubit.dart';
import 'package:nahj_balagha_flutter/shared/models/pagination.dart';

class NotificationsCubit extends PaginatedCubit<Mailbox, NotificationsState> {
  final GetNotificationsUseCase _getNotificationsUseCase;
  final SubscribeToTopicUseCase _subscribeToTopicUseCase;
  final UnsubscribeFromTopicUseCase _unsubscribeFromTopicUseCase;

  NotificationsCubit({
    required GetNotificationsUseCase getNotificationsUseCase,
    required SubscribeToTopicUseCase subscribeToTopicUseCase,
    required UnsubscribeFromTopicUseCase unsubscribeFromTopicUseCase,
  }) : _getNotificationsUseCase = getNotificationsUseCase,
       _subscribeToTopicUseCase = subscribeToTopicUseCase,
       _unsubscribeFromTopicUseCase = unsubscribeFromTopicUseCase,
       super(initialState: const NotificationsState());

  List<Mailbox> _notifications = [];
  final Set<String> _subscribedTopics = {};

  // Get subscribed topics
  Set<String> get subscribedTopics => Set.from(_subscribedTopics);

  // Check if subscribed to a topic
  bool isSubscribed(String topicId) => _subscribedTopics.contains(topicId);

  // Fetch Topics
  Future<void> fetchNotifications() async {
    if (isClosed) return;

    emitLoading();
    cancelInflight();

    setInflight(
      _getNotificationsUseCase(
        params: PaginationParams(pageNumber: 1, pageSize: pageSize),
      ),
    );

    final result = await getInflightResult();
    if (result == null || isClosed) return;

    if (result is Success) {
      final Pagination<Mailbox> pagination =
          result.response as Pagination<Mailbox>;
      _notifications = pagination.data;
      emitLoaded(_notifications, pagination);
    } else if (result is Failure) {
      ErrorMessageModel error = result.response;
      emitError(error.message);
    }
  }

  @override
  Future<void> loadMore() async {
    if (!shouldLoadMore()) {
      return;
    }

    emitLoadingMore();
    final nextPage = state.currentPage + 1;

    final result = await _getNotificationsUseCase(
      params: PaginationParams(pageNumber: nextPage, pageSize: pageSize),
    );

    if (result is Success) {
      final Pagination<Mailbox> pagination =
          result.response as Pagination<Mailbox>;
      _notifications = pagination.data;
      appendData(_notifications, pagination);
    } else if (result is Failure) {
      emit(state.copyWith(isLoadingMore: false, message: result.response));
    }
  }

  // Subscribe to a topic
  Future<bool> subscribeToTopic(String topicId) async {
    if (isClosed) return false;

    final result = await _subscribeToTopicUseCase(
      params: TopicIdParams(topicId: topicId),
    );

    if (result is Success) {
      _subscribedTopics.add(topicId);
      // Emit updated state
      emit(state.copyWith());
      return true;
    } else if (result is Failure) {
      ErrorMessageModel error = result.response;
      emitError(error.message);
      return false;
    }
    return false;
  }

  // Unsubscribe from a topic
  Future<bool> unsubscribeFromTopic(String topicId) async {
    if (isClosed) return false;

    final result = await _unsubscribeFromTopicUseCase(
      params: TopicIdParams(topicId: topicId),
    );

    if (result is Success) {
      _subscribedTopics.remove(topicId);
      // Emit updated state
      emit(state.copyWith());
      return true;
    } else if (result is Failure) {
      ErrorMessageModel error = result.response;
      emitError(error.message);
      return false;
    }
    return false;
  }

  @override
  Future<void> close() {
    _subscribedTopics.clear();
    return super.close();
  }
}
