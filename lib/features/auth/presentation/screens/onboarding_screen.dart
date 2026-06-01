import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/images.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/shared/components/app_image_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/elevated_button_widget.dart';
import 'package:nahj_balagha_flutter/shared/components/soft_divider_widget.dart.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsLight.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: HORIZONTAL,
            vertical: 20,
          ),
          child: Column(
            children: [
              const Spacer(flex: 2),

              // Islamic Star (8-pointed star)
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColorsLight.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Transform.rotate(
                    angle: 45 * 3.1415926535 / 180,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColorsLight.secondary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      color: AppColorsLight.primary,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  Transform.rotate(
                    angle: 45 * 3.1415926535 / 180,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        color: AppColorsLight.primary,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColorsLight.secondary.withAlpha(220),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Transform.rotate(
                    angle: 45 * 3.1415926535 / 180,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColorsLight.secondary.withAlpha(220),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),

              // Calligraphy Title
              AppImageWidget(
                path: AppAssets().nahjAlbalaghaManuscript,
                scale: 2,
                padding: const EdgeInsets.symmetric(vertical: 50),
              ),

              // Bio Description Text
              TextWidget(
                title:
                    "أهلاً بكم في التطبيق الجامع لعلوم نهج البلاغة، برعاية الأمانة العامة للعتبة العلوية المقدسة. رحلة إيمانية تبحر في أعماق الكلم الشريف، تجمع لك النفحات الصوتية، والحكم في واجهة تقنية عصرية.",
                fontSize: 14,
                height: 1.8,
                color: Colors.white,
                alignment: TextAlign.center,
              ),

              const Spacer(flex: 2),

              // Bottom Partners Logos
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 30,
                children: [
                  AppImageWidget(path: AppAssets().imamAliLogo, scale: 2),
                  const SoftDividerWidget(
                    axis: Axis.vertical,
                    color: AppColorsLight.white,
                    enableGradient: false,
                    length: 60,
                  ),
                  AppImageWidget(
                    path: AppAssets().haydaryaLibraryLogo,
                    scale: 2,
                  ),
                ],
              ),

              const Spacer(flex: 1),
              ElevatedButtonWidget(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.navigationScreen,
                    (route) => false,
                  );
                },
                title: "الدخول للتطبيق",
                backgroundColor: AppColorsLight.white,
                textColor: AppColorsLight.black,
              ),

              const SizedBox(height: PADDING_BOTTOM),
            ],
          ),
        ),
      ),
    );
  }
}
