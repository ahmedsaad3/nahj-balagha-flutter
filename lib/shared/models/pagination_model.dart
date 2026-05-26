import 'package:nahj_balagha_flutter/shared/models/pagination.dart';

class PaginationModel<T extends Object> extends Pagination<T> {
  const PaginationModel({
    required super.data,
    required super.pagesCount,
    required super.currentPage,
    required super.totalCount,
    required super.hasNextPage,
  });
  factory PaginationModel.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    List<T> data = (json['data'] as List)
        .map((item) => fromJsonT(item as Map<String, dynamic>))
        .toList();
    return PaginationModel(
      data: data,
      pagesCount: json['pagesCount'],
      currentPage: json['currentPage'],
      totalCount: json['totalCount'],
      hasNextPage: !json['isLast'],
    );
  }
}
