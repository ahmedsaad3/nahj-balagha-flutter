import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/browse/data/models/browse_dummy_data.dart';
import 'package:nahj_balagha_flutter/features/browse/presentation/controller/browse_state.dart';

class BrowseCubit extends Cubit<BrowseState> {
  BrowseCubit() : super(const BrowseState());

  void loadBrowseData() {
    emit(state.copyWith(requestState: RequestState.loading));
    try {
      final categories = BrowseDummyData.mockCategories;
      emit(state.copyWith(
        categories: categories,
        requestState: RequestState.loaded,
      ));
    } catch (e) {
      emit(state.copyWith(
        requestState: RequestState.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
