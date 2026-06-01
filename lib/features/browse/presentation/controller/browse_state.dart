import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/browse/domain/entities/browse_node.dart';

class BrowseState extends Equatable {
  final List<BrowseNode> categories;
  final RequestState requestState;
  final String errorMessage;

  const BrowseState({
    this.categories = const [],
    this.requestState = RequestState.idle,
    this.errorMessage = '',
  });

  BrowseState copyWith({
    List<BrowseNode>? categories,
    RequestState? requestState,
    String? errorMessage,
  }) {
    return BrowseState(
      categories: categories ?? this.categories,
      requestState: requestState ?? this.requestState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [categories, requestState, errorMessage];
}
