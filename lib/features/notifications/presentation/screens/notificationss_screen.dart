import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/services/services_locator.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/extensions/responsive_extensions.dart';
import 'package:nahj_balagha_flutter/features/notifications/domain/entities/notification.dart';
import 'package:nahj_balagha_flutter/features/notifications/presentation/components/notification_card_widget.dart';
import 'package:nahj_balagha_flutter/features/notifications/presentation/controller/mailbox/mailbox_cubit.dart';
import 'package:nahj_balagha_flutter/features/notifications/presentation/controller/mailbox/mailbox_state.dart';
import 'package:nahj_balagha_flutter/features/notifications/presentation/controller/notifications/notifications_cubit.dart';
import 'package:nahj_balagha_flutter/features/notifications/presentation/controller/notifications/notifications_state.dart';
import 'package:nahj_balagha_flutter/shared/components/bloc_state_builder_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/empty_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/refresh_indicator_widget.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<NotificationsCubit>()..fetchNotifications(),
        ),
        BlocProvider(create: (_) => sl<MailboxCubit>()..fetchMailbox()),
      ],
      child: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: PADDING_BOTTOM),
            TabBar(
              padding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              indicatorWeight: 3,
              tabs: [
                Tab(text: "الصندوق الوارد"),
                Tab(text: "الإشعارات"),
              ],
            ),
            const Expanded(
              child: TabBarView(children: [MailboxList(), NotificationsList()]),
            ),
          ],
        ),
      ),
    );
  }
}

class MailboxList extends StatelessWidget {
  const MailboxList({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicatorWidget(
      onRefresh: () async {
        await context.read<MailboxCubit>().fetchMailbox();
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo is ScrollUpdateNotification) {
            final maxScroll = scrollInfo.metrics.maxScrollExtent;
            final currentScroll = scrollInfo.metrics.pixels;
            final threshold = 0.9;

            if (currentScroll >= (maxScroll * threshold)) {
              context.read<MailboxCubit>().loadMore();
            }
          }
          return false;
        },
        child:
            BlocStateBuilderWidget<MailboxCubit, MailboxState, List<Mailbox>>(
              stateSelector: (state) => state.requestState,
              dataSelector: (state) => state.data,
              loadingBuilder: (context) => Column(),
              // loadingBuilder: (context) =>
              //     const BuildNotificationCardShimmerWidget(),
              loadedBuilder: (context, state, List<Mailbox> notifications) {
                return BuildNotificationCardWidget(
                  notifications: notifications,
                  isLoadingMore: state.isLoadingMore,
                );
              },
              emptyBuilder: (context) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: context.dimensions.screenHeight * 0.7,
                    child: Center(
                      child: EmptyWidget(title: "لا يوجد بيانات"),
                    ),
                  ),
                );
              },
              errorMessageSelector: (state) => state.message,
            ),
      ),
    );
  }
}

class NotificationsList extends StatelessWidget {
  const NotificationsList({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicatorWidget(
      onRefresh: () async {
        await context.read<NotificationsCubit>().fetchNotifications();
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo is ScrollUpdateNotification) {
            final maxScroll = scrollInfo.metrics.maxScrollExtent;
            final currentScroll = scrollInfo.metrics.pixels;
            final threshold = 0.9;

            if (currentScroll >= (maxScroll * threshold)) {
              context.read<NotificationsCubit>().loadMore();
            }
          }
          return false;
        },
        child:
            BlocStateBuilderWidget<
              NotificationsCubit,
              NotificationsState,
              List<Mailbox>
            >(
              stateSelector: (state) => state.requestState,
              dataSelector: (state) => state.data,
              loadingBuilder: (context) => Column(),
              loadedBuilder: (context, state, List<Mailbox> notifications) {
                return BuildNotificationCardWidget(
                  notifications: notifications,
                  isLoadingMore: state.isLoadingMore,
                );
              },
              emptyBuilder: (context) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: context.dimensions.screenHeight * 0.7,
                    child: Center(
                      child: EmptyWidget(title: "لا يوجد بيانات"),
                    ),
                  ),
                );
              },
              errorMessageSelector: (state) => state.message,
            ),
      ),
    );
  }
}
