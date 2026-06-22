import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/entities/scholar_entity.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/usecases/get_scholars_usecase.dart';
import 'package:nahj_balagha_flutter/features/scholars/presentation/controller/scholar_state.dart';
import 'package:nahj_balagha_flutter/shared/cubit/paginated/paginated_cubit.dart';
import 'package:nahj_balagha_flutter/shared/models/pagination.dart';

class ScholarCubit extends PaginatedCubit<ScholarEntity, ScholarState> {
  final GetScholarsUseCase _getScholarsUseCase;

  ScholarCubit({required GetScholarsUseCase getScholarsUseCase})
    : _getScholarsUseCase = getScholarsUseCase,
      super(initialState: const ScholarState());

  Future<void> fetchBooks() async {
    emitLoading();

    final params = PaginationParams(pageNumber: 1, pageSize: pageSize);
    final result = await _getScholarsUseCase(params: params);

    if (result is Success) {
      final pagination = result.response as Pagination<ScholarEntity>;
      emitLoaded(pagination.data, pagination);
      return;
    }

    if (result is Failure) {
      emitError(result.response);
      return;
    }
  }

  @override
  Future<void> loadMore() async {
    if (!shouldLoadMore()) {
      return;
    }

    emitLoadingMore();

    final nextPage = state.currentPage + 1;
    final params = PaginationParams(pageNumber: nextPage, pageSize: pageSize);

    final result = await _getScholarsUseCase(params: params);

    if (result is Success) {
      final pagination = result.response as Pagination<ScholarEntity>;
      appendData(pagination.data, pagination);
      return;
    }

    if (result is Failure) {
      resetLoadingMore();
      emit(
        state.copyWith(
          isLoadingMore: false,
          hasMorePages: false,
          message: result.response,
        ),
      );
      return;
    }
  }
}
