import 'package:flutter/material.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/features/navigation/presentation/screen/navigation_screen.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsLight.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: HORIZONTAL, vertical: 20),
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

              const SizedBox(height: 40),

              // Calligraphy Title
              const TextWidget(
                title: "مَعَارِفُ نَهْجِ الْبَلَاغَةِ",
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                alignment: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // Bio Description Text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextWidget(
                  title:
                      "أهلاً بكم في التطبيق الجامع لعلوم نهج البلاغة، برعاية الأمانة العامة للعتبة العلوية المقدسة. رحلة إيمانية تبحر في أعماق الكلم الشريف، تجمع لك النفحات الصوتية، والحكم في واجهة تقنية عصرية.",
                  fontSize: 14,
                  height: 1.8,
                  color: Colors.white,
                  alignment: TextAlign.center,
                ),
              ),

              const Spacer(flex: 2),

              // Bottom Partners Logos
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withAlpha(180), width: 1.5),
                    ),
                    child: const Icon(
                      Icons.menu_book_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    height: 40,
                    width: 1.5,
                    color: Colors.white.withAlpha(120),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withAlpha(180), width: 1.5),
                    ),
                    child: const Icon(
                      Icons.account_balance_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),

              const Spacer(flex: 1),

              // Enter Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColorsLight.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NavigationScreen(),
                      ),
                    );
                  },
                  child: const TextWidget(
                    title: "الدخول للتطبيق",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColorsLight.textPrimary,
                  ),
                ),
              ),

              const SizedBox(height: PADDING_BOTTOM),
            ],
          ),
        ),
      ),
    );
  }
}
