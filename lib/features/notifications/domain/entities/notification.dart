import 'package:equatable/equatable.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';

class Mailbox extends Equatable {
  final String id;
  final String description;
  final String createdDate;
  final bool isRead;
  final String title;
  final String? image;
  final int type;
  final String? path;
  final String? coverImage;
  final String? creatorName;

  const Mailbox({
    required this.id,
    required this.description,
    required this.createdDate,
    required this.isRead,
    required this.title,
    this.image,
    required this.type,
    this.path,
    this.coverImage,
    this.creatorName,
  });

  NotificationType getNotificationType() {
    return NotificationTypeExtension.fromInt(type);
  }

  String? getBookIdFromPath() {
    if (path == null || path!.isEmpty) return null;
    return path;
  }

  @override
  List<Object?> get props => [
    id,
    description,
    createdDate,
    isRead,
    title,
    image,
    type,
    path,
    coverImage,
    creatorName,
  ];
}
