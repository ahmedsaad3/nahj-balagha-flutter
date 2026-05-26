import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/notifications/domain/repository/base_notifications_repository.dart';

class GetMailboxUseCase implements BaseUseCase<Result, PaginationParams> {
  final BaseNotificationsRepository baseNotificationsRepository;

  GetMailboxUseCase({required this.baseNotificationsRepository});

  @override
  Future<Result> call({required PaginationParams params}) async {
    return await baseNotificationsRepository.getMailbox(params: params);
  }
}
