import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/home/domain/entities/hikmah_entity.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/entities/scholar_entity.dart';

class HomeState extends Equatable {
  final RequestState hikmahState;
  final HikmahEntity? hikmah;
  final String hikmahErrorMessage;

  final RequestState scholarsState;
  final List<ScholarEntity> scholars;
  final String scholarErrorMessage;

  const HomeState({
    this.hikmahState = RequestState.idle,
    this.hikmah,
    this.hikmahErrorMessage = '',
    this.scholarsState = RequestState.idle,
    this.scholars = const [],
    this.scholarErrorMessage = '',
  });

  HomeState copyWith({
    RequestState? hikmahState,
    HikmahEntity? hikmah,
    String? hikmahErrorMessage,
    RequestState? scholarsState,
    List<ScholarEntity>? scholars,
    String? scholarErrorMessage,
  }) {
    return HomeState(
      hikmahState: hikmahState ?? this.hikmahState,
      hikmah: hikmah ?? this.hikmah,
      hikmahErrorMessage: hikmahErrorMessage ?? this.hikmahErrorMessage,
      scholarsState: scholarsState ?? this.scholarsState,
      scholars: scholars ?? this.scholars,
      scholarErrorMessage: scholarErrorMessage ?? this.scholarErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    hikmahState,
    hikmah,
    hikmahErrorMessage,
    scholarsState,
    scholars,
    scholarErrorMessage,
  ];
}