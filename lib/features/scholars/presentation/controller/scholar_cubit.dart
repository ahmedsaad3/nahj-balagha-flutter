import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/usecases/get_scholars_usecase.dart';
import 'package:nahj_balagha_flutter/features/scholars/presentation/controller/scholar_state.dart';

class ScholarCubit extends Cubit<ScholarState> {
  final GetScholarsUseCase _getScholarsUseCase;

  ScholarCubit(this._getScholarsUseCase) : super(const ScholarState());

  Future<void> getScholars() async {
    emit(
      state.copyWith(
        scholarsState: RequestState.loading,
        scholarsMessage: '',
        scholars: [],
      ),
    );
    final result = await _getScholarsUseCase();
    switch (result) {
      case Success(response: final response):
        emit(
          state.copyWith(
            scholarsState: RequestState.loaded,
            scholars: response,
            scholarsMessage: '',
          ),
        );
      case Failure():
        emit(
          state.copyWith(
            scholarsState: RequestState.error,
            scholarsMessage: 'حدث خطأ',
            scholars: [],
          ),
        );
    }
  }
}
