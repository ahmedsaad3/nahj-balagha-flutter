import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/network/error_message_model.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/usecase/base_usecase.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/home/domain/usecases/get_home_data_usecase.dart';
import 'package:nahj_balagha_flutter/features/home/presentation/controller/home_state.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/entities/scholar_entity.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/usecases/get_scholars_usecase.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeDataUseCase getHomeDataUseCase;
  final GetScholarsUseCase _getScholarsUseCase;

  List<ScholarEntity> _scholars = [];

  HomeCubit({
    required this.getHomeDataUseCase,
    required GetScholarsUseCase getScholarsUseCase,
  }) : _getScholarsUseCase = getScholarsUseCase,
       super(const HomeState());

  Future<void> loadHomeData() async {
    await fetchScholars();
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await getHomeDataUseCase.call();
    if (result.response != null) {
      emit(
        state.copyWith(
          requestState: RequestState.loaded,
          homeData: result.response,
        ),
      );
    } else {
      emit(
        state.copyWith(
          requestState: RequestState.error,
          errorMessage: 'Failed to load home data',
        ),
      );
    }
  }

  Future<void> fetchScholars() async {
    if (isClosed) return;

    emit(state.copyWith(scholarsState: RequestState.loading));
    // Return cached categories if available
    if (_scholars.isNotEmpty) {
      emit(
        state.copyWith(scholarsState: RequestState.loaded, scholars: _scholars),
      );
      return;
    }

    final Result result = await _getScholarsUseCase(
      params: ScholarParams(
        pageNumber: 1,
        pageSize: 8,
        personTypeId: '1e9ca45c-0118-47c3-8eb1-e2307bdc526d',
      ),
    );

    if (result.response == null || isClosed) return;

    if (result is Success) {
      _scholars = result.response.data;
      emit(
        state.copyWith(scholarsState: RequestState.loaded, scholars: _scholars),
      );
    } else if (result is Failure) {
      ErrorMessageModel errorMessage = result.response;
      emit(
        state.copyWith(
          scholarsState: RequestState.error,
          scholarErrorMessage: errorMessage.message,
        ),
      );
    }
  }
}
