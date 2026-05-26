enum RequestState { idle, loading, loaded, error }

enum ImageType { svg, asset, icon, network, networkSvg }

enum CollectionLayout { grid, list }

enum NotificationType {
  book, // 1
  link, // 2
  service, // 3
  notification, // 4
}

extension NotificationTypeExtension on NotificationType {
  static NotificationType fromInt(int value) {
    switch (value) {
      case 1:
        return NotificationType.book;
      case 2:
        return NotificationType.link;
      case 3:
        return NotificationType.service;
      case 4:
        return NotificationType.notification;
      default:
        return NotificationType.notification;
    }
  }
}
