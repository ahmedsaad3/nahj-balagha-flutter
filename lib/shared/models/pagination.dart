import 'package:equatable/equatable.dart';

class Pagination<T extends Object> extends Equatable {
  final List<T> data;
  final int pagesCount;
  final int currentPage;
  final int totalCount;
  final bool hasNextPage;

  const Pagination({
    required this.data,
    required this.pagesCount,
    required this.currentPage,
    required this.totalCount,
    required this.hasNextPage,
  });

  @override
  List<Object?> get props => [
    data,
    pagesCount,
    currentPage,
    totalCount,
    hasNextPage,
  ];
}
