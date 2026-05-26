import 'package:nahj_balagha_flutter/features/notifications/domain/entities/notification.dart';

class NotificationModel extends Mailbox {
  const NotificationModel({
    required super.id,
    required super.description,
    required super.createdDate,
    required super.isRead,
    required super.title,
    required super.image,
    required super.type,
    required super.path,
    required super.coverImage,
    required super.creatorName,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: (json["emailID"] ?? json["notificationID"]).toString(),
        description: json["description"],
        createdDate: json["createdDate"],
        isRead: json["isRead"],
        title: json["title"],
        image: json["image"],
        type: json["type"],
        path: json["path"],
        coverImage: json["coverImage"],
        creatorName: json["creatorName"],
      );
}
