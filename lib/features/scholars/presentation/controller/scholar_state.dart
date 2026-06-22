import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/features/scholars/domain/entities/scholar_entity.dart';
import 'package:nahj_balagha_flutter/shared/cubit/paginated/paginated_state.dart';

class ScholarState extends PaginatedState<ScholarEntity> {
  const ScholarState({
    List<ScholarEntity> scholars = const [],
    super.requestState = RequestState.idle,
    super.message = '',
    super.currentPage = 1,
    super.totalPages = 1,
    super.hasMorePages = false,
    super.isLoadingMore = false,
  }) : super(data: scholars);

  List<ScholarEntity> get scholars => data;

  @override
  ScholarState copyWith({
    RequestState? requestState,
    List<ScholarEntity>? data,
    String? message,
    int? currentPage,
    int? totalPages,
    bool? hasMorePages,
    bool? isLoadingMore,
  }) {
    return ScholarState(
      requestState: requestState ?? this.requestState,
      scholars: data ?? this.data,
      message: message ?? this.message,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      hasMorePages: hasMorePages ?? this.hasMorePages,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [...super.props, scholars];
}
