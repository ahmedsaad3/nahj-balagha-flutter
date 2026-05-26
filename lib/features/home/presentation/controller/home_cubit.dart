import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/home/domain/usecases/get_home_data_usecase.dart';
import 'package:nahj_balagha_flutter/features/home/presentation/controller/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeDataUseCase getHomeDataUseCase;

  HomeCubit({required this.getHomeDataUseCase}) : super(const HomeState());

  Future<void> loadHomeData() async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await getHomeDataUseCase.call();
    if (result.response != null) {
      emit(state.copyWith(
        requestState: RequestState.loaded,
        homeData: result.response,
      ));
    } else {
      emit(state.copyWith(
        requestState: RequestState.error,
        errorMessage: 'Failed to load home data',
      ));
    }
  }
}
