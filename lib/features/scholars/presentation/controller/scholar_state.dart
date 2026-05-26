import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/entities/scholar_entity.dart';

class ScholarState extends Equatable {
  final List<ScholarEntity> scholars;
  final RequestState scholarsState;
  final String scholarsMessage;

  const ScholarState({
    this.scholars = const [],
    this.scholarsState = RequestState.idle,
    this.scholarsMessage = '',
  });

  ScholarState copyWith({
    List<ScholarEntity>? scholars,
    RequestState? scholarsState,
    String? scholarsMessage,
  }) {
    return ScholarState(
      scholars: scholars ?? this.scholars,
      scholarsState: scholarsState ?? this.scholarsState,
      scholarsMessage: scholarsMessage ?? this.scholarsMessage,
    );
  }

  @override
  List<Object?> get props => [scholars, scholarsState, scholarsMessage];
}
