import 'package:flutter/material.dart' hide Notification;
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/ui_utils.dart';
import 'package:nahj_balagha_flutter/extensions/responsive_extensions.dart';
import 'package:nahj_balagha_flutter/features/notifications/domain/entities/notification.dart';
import 'package:nahj_balagha_flutter/shared/components/collection_view_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/elevated_button_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/soft_divider_widget.dart.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class NotificationCardWidget extends StatelessWidget {
  final Mailbox notification;

  const NotificationCardWidget({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: AppColorsLight.white,
        borderRadius: BorderRadius.circular(RADIUS),
      ),
      child: Column(
        spacing: 14,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and sender name
          Row(
            spacing: 12,
            children: [
              // Icon on the right
              Container(
                decoration: BoxDecoration(boxShadow: [UiUtils.softShadow()]),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColorsLight.white,
                  // child: AppImageWidget(
                  //   imageType: ImageType.svg,
                  //   path: AppAssets().supportIcon,
                  //   size: 24,
                  //   color: AppColorsLight.accent,
                  // ),
                ),
              ),
              // Title
              Expanded(
                child: TextWidget(
                  title: notification.title,
                  fontSize: 14,
                  color: AppColorsLight.primary,
                ),
              ),
            ],
          ),

          // Message text
          TextWidget(
            title: notification.description,
            fontSize: 16,
            color: AppColorsLight.gray,
            height: 1.6,
          ),
          // Link button (if provided)
          if (notification.path != null && notification.path != "4") ...[
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButtonWidget(
                onPressed: () => _onNotificationTap(
                  context: context,
                  notification: notification,
                ),
                title: getButtonText(context),
                fontSize: 14,
                backgroundColor: AppColorsLight.accent,
                width: context.dimensions.screenWidth * 0.35,
                imageType: ImageType.icon,
                icon: getButtonIcon(),
                iconColor: AppColorsLight.white,
                iconSize: 24,
              ),
            ),
          ],

          // Date
          Align(
            alignment: Alignment.centerLeft,
            child: TextWidget(
              title: UiUtils.formatDate(
                context: context,
                dateString: notification.createdDate,
              ),
              fontSize: 12,
              color: AppColorsLight.primary,
            ),
          ),
        ],
      ),
    );
  }

  String getButtonText(BuildContext context) {
    switch (notification.getNotificationType()) {
      case NotificationType.book:
        return "عرض الكتاب";
      case NotificationType.link:
        return "فتح الرابط";
      case NotificationType.service:
        return "عرض الخدمة";
      case NotificationType.notification:
        return "";
    }
  }

  IconData getButtonIcon() {
    switch (notification.getNotificationType()) {
      case NotificationType.book:
        return Icons.book;
      case NotificationType.link:
        return Icons.link;
      case NotificationType.service:
        return Icons.home_repair_service_outlined;
      case NotificationType.notification:
        return Icons.info_outline;
    }
  }

  void _onNotificationTap({
    required BuildContext context,
    required Mailbox notification,
  }) {
    switch (notification.getNotificationType()) {
      case NotificationType.book:
        final bookId = notification.getBookIdFromPath();
        if (bookId != null) {
          // final book = Book(
          //   id: bookId,
          //   title: notification.title,
          //   authorName: notification.creatorName!,
          //   coverImage: notification.coverImage,
          // );
          // Navigator.pushNamed(
          //   context,
          //   AppRoutes.bookDetailScreen,
          //   arguments: book,
          // );
        }
        break;
      case NotificationType.link:
        if (notification.path != null) {
          UiUtils.launchURL(url: notification.path!);
        }
        break;
      case NotificationType.service:
        break;
      case NotificationType.notification:
        // Do nothing for display-only advertisements
        break;
    }
  }
}

class BuildNotificationCardWidget extends StatelessWidget {
  final List<Mailbox> notifications;
  final bool isLoadingMore;
  const BuildNotificationCardWidget({
    super.key,
    required this.notifications,
    required this.isLoadingMore,
  });

  @override
  Widget build(BuildContext context) {
    return CollectionViewWidget(
      itemCount: notifications.length,
      horizontal: HORIZONTAL,
      vertical: 20,
      shimmerCount: 3,
      physics: const AlwaysScrollableScrollPhysics(),
      isLoadingMore: isLoadingMore,
      separatorBuilder: (BuildContext context, int index) => const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: SoftDividerWidget(thickness: 1.5),
      ),
      itemBuilder: (context, index) {
        final item = notifications[index];
        return NotificationCardWidget(notification: item);
      },
      // shimmerWidget: const NotificationCardShimmerWidget(),
    );
  }
}
