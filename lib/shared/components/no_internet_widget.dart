import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';
import 'package:nahj_balagha_flutter/shared/cubit/connectivity/connectivity_cubit.dart';
import 'package:nahj_balagha_flutter/shared/cubit/connectivity/connectivity_state.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ConnectivityCubit, ConnectivityState, bool>(
      selector: (state) {
        return state.isConnected;
      },
      builder: (context, isConnected) {
        if (!isConnected) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: AppColorsLight.red,
            child: SafeArea(
              bottom: false,
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, color: Colors.white, size: 20),
                  TextWidget(
                    title: "لا يوجد انترنت",
                    color: AppColorsLight.white,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
