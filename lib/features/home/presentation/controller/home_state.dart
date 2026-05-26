import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/home/domain/entities/home_data.dart';

class HomeState extends Equatable {
  final RequestState requestState;
  final HomeData? homeData;
  final String errorMessage;

  const HomeState({
    this.requestState = RequestState.idle,
    this.homeData,
    this.errorMessage = '',
  });

  HomeState copyWith({
    RequestState? requestState,
    HomeData? homeData,
    String? errorMessage,
  }) {
    return HomeState(
      requestState: requestState ?? this.requestState,
      homeData: homeData ?? this.homeData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [requestState, homeData, errorMessage];
}
