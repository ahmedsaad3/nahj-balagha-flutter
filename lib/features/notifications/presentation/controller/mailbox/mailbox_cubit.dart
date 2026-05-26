import 'package:nahj_balagha_flutter/core/network/error_message_model.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/notifications/domain/entities/notification.dart';
import 'package:nahj_balagha_flutter/features/notifications/domain/usecases/get_mailbox_usecase.dart';
import 'package:nahj_balagha_flutter/features/notifications/presentation/controller/mailbox/mailbox_state.dart';
import 'package:nahj_balagha_flutter/shared/cubit/paginated/paginated_cubit.dart';
import 'package:nahj_balagha_flutter/shared/models/pagination.dart';

class MailboxCubit extends PaginatedCubit<Mailbox, MailboxState> {
  final GetMailboxUseCase _getMailboxUseCase;

  MailboxCubit({required GetMailboxUseCase getMailboxUseCase})
    : _getMailboxUseCase = getMailboxUseCase,
      super(initialState: const MailboxState());

  List<Mailbox> _mailboxMessages = [];

  // Fetch Mailbox
  Future<void> fetchMailbox() async {
    if (isClosed) return;

    emitLoading();
    cancelInflight();

    setInflight(
      _getMailboxUseCase(
        params: PaginationParams(pageNumber: 1, pageSize: pageSize),
      ),
    );

    final result = await getInflightResult();
    if (result == null || isClosed) return;

    if (result is Success) {
      final Pagination<Mailbox> pagination =
          result.response as Pagination<Mailbox>;
      _mailboxMessages = pagination.data;
      emitLoaded(_mailboxMessages, pagination);
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

    final result = await _getMailboxUseCase(
      params: PaginationParams(pageNumber: nextPage, pageSize: pageSize),
    );

    if (result is Success) {
      final Pagination<Mailbox> pagination =
          result.response as Pagination<Mailbox>;
      _mailboxMessages = pagination.data;
      appendData(_mailboxMessages, pagination);
    } else if (result is Failure) {
      emit(state.copyWith(isLoadingMore: false, message: result.response));
    }
  }
}
