import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/ui_utils.dart';
import 'package:nahj_balagha_flutter/features/navigation/presentation/components/nav_widget.dart';
import 'package:nahj_balagha_flutter/features/navigation/presentation/controller/navigation_cubit.dart';
import 'package:nahj_balagha_flutter/features/navigation/presentation/controller/navigation_state.dart';
import 'package:nahj_balagha_flutter/shared/components/app_image_widget.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: UiUtils.appBar(
            context: context,
            leading: Builder(
              builder: (context) {
                return AppImageWidget(
                  imageType: ImageType.icon,
                  icon: Icons.notifications,
                  size: 24,
                  color: AppColorsLight.white,
                  padding: EdgeInsets.zero,
                );
              },
            ),
            centerTitle: true,
          ),
          bottomNavigationBar: state.selectedIndex < 4
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // UiUtils.preferredBottom(),
                    navWidget(
                      onTap: (index) =>
                          context.read<NavigationCubit>().onItemTapped(index),
                      currentIndex: state.selectedIndex,
                      context: context,
                    ),
                  ],
                )
              : null,
          body: IndexedStack(
            index: state.selectedIndex,
            children: state.screens.asMap().entries.map((entry) {
              int index = entry.key;
              Widget originalScreen = entry.value;

              if (state.replacedScreens.containsKey(index)) {
                return state.replacedScreens[index]!;
              }

              return originalScreen;
            }).toList(),
          ),
        );
      },
    );
  }
}
