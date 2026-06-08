import 'package:nahj_balagha_flutter/features/search/domain/entities/search_result_entity.dart';

class SearchModel extends SearchResultEntity {
  const SearchModel({
    required super.id,
    required super.title,
    required super.content,
    required super.filter,
    required super.category,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      filter: json['filter'] as String? ?? '',
      category: json['category'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'filter': filter,
      'category': category,
    };
  }
}
