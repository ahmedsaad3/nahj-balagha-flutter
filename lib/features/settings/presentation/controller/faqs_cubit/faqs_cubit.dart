import 'package:async/async.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/network/error_message_model.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/settings/domain/entities/faqs.dart';
import 'package:nahj_balagha_flutter/features/settings/domain/usecases/get_faqs_usecase.dart';
import 'package:nahj_balagha_flutter/features/settings/presentation/controller/faqs_cubit/faqs_state.dart';

class FAQsCubit extends Cubit<FAQsState> {
  final GetFAQsUseCase _getFAQsUseCase;
  FAQsCubit({required GetFAQsUseCase qetFAQsUseCase})
    : _getFAQsUseCase = qetFAQsUseCase,
      super(const FAQsState());

  CancelableOperation? _inflight;
  List<FAQs> _faqs = [];

  void toggleExpanded({required String faqId}) {
    if (isClosed) return;
    final currentExpandedId = state.expandedFaqId;

    if (currentExpandedId == faqId) {
      emit(state.copyWith(clearExpandedFaqId: true));
    } else {
      emit(state.copyWith(expandedFaqId: faqId));
    }
  }

  void updateSearchQuery(String query) {
    if (isClosed) return;
    emit(state.copyWith(searchQuery: query, clearExpandedFaqId: true));
  }

  Future<void> fetchFaqs() async {
    if (isClosed) return;
    emit(state.copyWith(faqsState: RequestState.loading));
    _inflight?.cancel();

    if (_faqs.isNotEmpty) {
      emit(state.copyWith(faqsState: RequestState.loaded, faqs: _faqs));
      return;
    }
    _inflight = CancelableOperation.fromFuture(_getFAQsUseCase());

    final result = await _inflight?.value;

    if (result is Success) {
      _faqs = result.response;
      emit(state.copyWith(faqsState: RequestState.loaded, faqs: _faqs));
    } else {
      ErrorMessageModel errorMessage = result.response;
      emit(
        state.copyWith(
          faqsState: RequestState.error,
          errorMessage: errorMessage.message,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _inflight?.cancel();
    return super.close();
  }
}
