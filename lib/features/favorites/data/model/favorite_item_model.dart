import 'package:nahj_balagha_flutter/features/favorites/domain/entities/favorite_item.dart';

class FavoriteItemModel extends FavoriteItem {
  const FavoriteItemModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.url,
    required super.hasAudio,
  });

  factory FavoriteItemModel.fromJson(Map<String, dynamic> json) {
    return FavoriteItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      url: json['url'] as String? ?? '',
      hasAudio: json['hasAudio'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'url': url,
      'hasAudio': hasAudio,
    };
  }
}
