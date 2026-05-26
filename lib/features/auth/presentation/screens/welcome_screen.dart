import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahj_balagha_flutter/core/services/dropdown_info_multi.dart';
import 'package:nahj_balagha_flutter/core/services/multi_item_model.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/enums.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/auth_cubit/auth_cubit.dart';
import 'package:nahj_balagha_flutter/features/settings/presentation/controller/settings_cubit/settings_cubit.dart';
import 'package:nahj_balagha_flutter/features/settings/presentation/controller/settings_cubit/settings_state.dart';
import 'package:nahj_balagha_flutter/shared/components/app_image_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/dropdown_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/elevated_button_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        minimum: const EdgeInsets.symmetric(horizontal: HORIZONTAL),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BlocSelector<SettingsCubit, SettingsState, Locale?>(
                        selector: (state) {
                          return state.locale;
                        },
                        builder: (context, locale) {
                          return DropdownWidget(
                            value: locale?.languageCode ?? 'system',
                            items: fillDropdownMulti(context, itemsLanguages),
                            onChanged: (value) {
                              if (value != null) {
                                context.read<SettingsCubit>().changeLanguage(
                                  languageCode: value,
                                );
                              }
                              return;
                            },
                          );
                        },
                      ),

                      InkWell(
                        onTap: () {
                          context.read<AuthCubit>().setGuestStatus(true);
                        },
                        borderRadius: BorderRadius.circular(RADIUS),
                        child: TextWidget(
                          title: "ضيف",
                          fontSize: 12,
                          color: AppColorsLight.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 5,
                    children: [
                      AppImageWidget(
                        imageType: ImageType.svg,
                        // path: AppAssets().haydaryaLibraryLogo,
                        size: 130,
                        color: AppColorsLight.primary,
                      ),
                      AppImageWidget(
                        imageType: ImageType.svg,
                        // path: AppAssets().haydaryaTextLogo,
                        size: 50,
                        color: AppColorsLight.primary,
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  TextWidget(
                    title: "مرحبا بكم في تطبيق نهج البلاغة",
                    fontWeight: FontWeight.bold,
                    color: AppColorsLight.primary,
                  ),
                  const Spacer(),
                  ElevatedButtonWidget(
                    backgroundColor: AppColorsLight.accent,
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.signinScreen);
                    },
                    title: "تسجيل الدخول",
                  ),
                  ElevatedButtonWidget(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.signupScreen);
                    },
                    title: "إنشاء حساب جديد",
                    // backgroundColor: context.scaffoldBackground,
                    textColor: AppColorsLight.accent,
                    isBorderSide: true,
                  ),
                  const SizedBox(height: PADDING_BOTTOM),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
