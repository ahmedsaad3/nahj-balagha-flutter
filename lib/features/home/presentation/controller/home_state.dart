import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/home/domain/entities/home_data.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/entities/scholar_entity.dart';

class HomeState extends Equatable {
  final RequestState requestState;
  final HomeData? homeData;
  final String errorMessage;

  final RequestState scholarsState;
  final List<ScholarEntity> scholars;
  final String scholarErrorMessage;

  const HomeState({
    this.requestState = RequestState.idle,
    this.homeData,
    this.errorMessage = '',
    this.scholarsState = RequestState.idle,
    this.scholars = const [],
    this.scholarErrorMessage = '',
  });

  HomeState copyWith({
    RequestState? requestState,
    HomeData? homeData,
    String? errorMessage,
    RequestState? scholarsState,
    List<ScholarEntity>? scholars,
    String? scholarErrorMessage,
  }) {
    return HomeState(
      requestState: requestState ?? this.requestState,
      homeData: homeData ?? this.homeData,
      errorMessage: errorMessage ?? this.errorMessage,
      scholarsState: scholarsState ?? this.scholarsState,
      scholars: scholars ?? this.scholars,
      scholarErrorMessage: scholarErrorMessage ?? this.scholarErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    requestState,
    homeData,
    errorMessage,
    scholarsState,
    scholars,
    scholarErrorMessage,
  ];
}
