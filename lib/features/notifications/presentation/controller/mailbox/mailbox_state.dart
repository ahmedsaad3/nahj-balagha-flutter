import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/notifications/domain/entities/notification.dart';
import 'package:nahj_balagha_flutter/shared/cubit/paginated/paginated_state.dart';

class MailboxState extends PaginatedState<Mailbox> {
  const MailboxState({
    super.requestState = RequestState.idle,
    super.data = const [],
    super.message = '',
    super.currentPage = 1,
    super.totalPages = 1,
    super.hasMorePages = false,
    super.isLoadingMore = false,
  });

  @override
  List<Object?> get props => [...super.props, data];

  @override
  MailboxState copyWith({
    RequestState? requestState,
    List<Mailbox>? data,
    String? message,
    int? currentPage,
    int? totalPages,
    bool? hasMorePages,
    bool? isLoadingMore,
  }) {
    return MailboxState(
      requestState: requestState ?? this.requestState,
      data: data ?? this.data,
      message: message ?? this.message,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasMorePages: hasMorePages ?? this.hasMorePages,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
