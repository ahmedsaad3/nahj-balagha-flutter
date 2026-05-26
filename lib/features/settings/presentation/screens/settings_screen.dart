import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/core/utils/ui_utils.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/auth_cubit/auth_state.dart';
import 'package:nahj_balagha_flutter/shared/components/confirm_buttons_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/elevated_button_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/soft_divider_widget.dart.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: PADDING_BOTTOM),
                // HeaderWidget(
                //   title: context.localizations.settings,
                //   subtitle: context.localizations.technicalSupport,
                // ),
                const SizedBox(height: 10),
                // CustomListTile(
                //   title: context.localizations.faqs,
                  // asset: AppAssets().bookQuestionsIcon,
                //   onTap: () =>
                //       Navigator.pushNamed(context, AppRoutes.faqsScreen),
                // ),
                const SoftDividerWidget(),
                // BlocSelector<AuthCubit, AuthState, bool>(
                //   selector: (state) => state.isGuest,
                //   builder: (context, isGuest) {
                //     if (isGuest) return const SizedBox.shrink();
                //     return Column(
                //       children: [
                //         CustomListTile(
                //           title: context.localizations.reviews,
                //           asset: AppAssets().reviewsIcon,
                //           onTap: () => Navigator.pushNamed(
                //             context,
                //             AppRoutes.reviewsAndCommentsScreen,
                //           ),
                //         ),
                //         const SoftDividerWidget(),
                //       ],
                //     );
                //   },
                // ),
                // CustomListTile(
                //   title: context.localizations.privacyPolicy,
                //   asset: AppAssets().passwordCircleIcon,
                //   onTap: () {},
                // ),
                // const SoftDividerWidget(),
                // BlocSelector<AuthCubit, AuthState, bool>(
                //   selector: (state) => state.isGuest,
                //   builder: (context, isGuest) {
                //     if (isGuest) return const SizedBox.shrink();
                //     return Column(
                //       children: [
                //         CustomListTile(
                //           title: context.localizations.accountInfo,
                //           asset: AppAssets().personalIcon,
                //           onTap: () => Navigator.pushNamed(
                //             context,
                //             AppRoutes.profileScreen,
                //           ),
                //         ),
                //         const SoftDividerWidget(),
                //         CustomListTile(
                //           title: context.localizations.changePassword,
                //           asset: AppAssets().passwordIcon,
                //           onTap: () => Navigator.pushNamed(
                //             context,
                //             AppRoutes.changePasswordScreen,
                //           ),
                //         ),
                //         const SoftDividerWidget(),
                //       ],
                //     );
                //   },
                // ),
                // BlocSelector<SettingsCubit, SettingsState, Locale?>(
                //   selector: (state) {
                //     return state.locale;
                //   },
                //   builder: (context, locale) {
                //     return CustomListTileWithSwitch(
                //       title: context.localizations.language,
                //       asset: AppAssets().languageIcon,
                //       color: AppColorsLight.primary,
                //       trailing: DropdownWidget(
                //         value: locale?.languageCode ?? 'system',
                //         items: fillDropdownMulti(context, itemsLanguages),
                //         onChanged: (value) {
                //           if (value != null) {
                //             context.read<SettingsCubit>().changeLanguage(
                //               languageCode: value,
                //             );
                //           }
                //           return;
                //         },
                //       ),
                //     );
                //   },
                // ),
              ]),
            ),
          ),
          BlocSelector<AuthCubit, AuthState, bool>(
            selector: (state) => state.isGuest,
            builder: (context, isGuest) {
              if (isGuest) {
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              }
              return SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: HORIZONTAL,
                    vertical: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButtonWidget(
                        title: "تسجيل الخروج",
                        backgroundColor: AppColorsLight.red,
                        textColor: AppColorsLight.white,
                        // iconAsset: AppAssets().logoutIcon,
                        iconColor: AppColorsLight.white,
                        imageType: ImageType.svg,
                        onPressed: () {
                          UiUtils.showDialogWidgetWithAnimation(
                            context: context,
                            title: "تأكيد تسجيل الخروج",
                            child: ConfirmButtonsWidget(
                              onYes: () {
                                context.read<AuthCubit>().logout().then(
                                  (value) => Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppRoutes.welcomeScreen,
                                    (route) => false,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
