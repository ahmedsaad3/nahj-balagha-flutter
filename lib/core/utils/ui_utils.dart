import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nahj_balagha_flutter/core/services/dropdown_info_multi.dart';
import 'package:nahj_balagha_flutter/core/services/multi_item_model.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/theme/app_color/app_colors_light.dart';
import 'package:nahj_balagha_flutter/extensions/context_extensions.dart';
import 'package:nahj_balagha_flutter/shared/components/text_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class UiUtils {
  static String formatDate({
    required String dateString,
    required BuildContext context,
  }) {
    if (dateString.isEmpty) return "";
    try {
      final DateTime date = DateTime.parse(dateString);
      final String formattedTime = DateFormat("hh:mm", "en").format(date);
      final String formattedDay = DateFormat(
        "EEEE",
        context.localizations.locale,
      ).format(date);
      final String formattedAmPm = DateFormat(
        "a",
        context.localizations.locale,
      ).format(date);
      // final String formattedDay = DateFormat("EEEE", "ar").format(date);
      // final String formattedAmPm = DateFormat("a", "ar").format(date);
      final String formattedDate =
          "$formattedDay $formattedTime $formattedAmPm";
      return formattedDate;
    } catch (e) {
      return dateString;
    }
  }

  static AppBar appBar({
    required BuildContext context,
    String? title,
    Widget? titleWidget,
    Color? backgroundColor,
    VoidCallback? onPressedBack,
    Widget? action,
    Widget? leading,
    Color? backIconColor = AppColorsLight.white,
    PreferredSizeWidget? bottom,
    EdgeInsets? actionsPadding = EdgeInsets.zero,
    bool centerTitle = false,
    double? titleSpacing,
  }) {
    return AppBar(
      backgroundColor: backgroundColor,
      leading:
          leading ??
          IconButton(
            onPressed: onPressedBack ?? () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_rounded, color: backIconColor),
          ),
      titleSpacing: titleSpacing,
      title: titleWidget ?? TextWidget(title: title ?? "", fontSize: 16),
      actionsPadding: actionsPadding,
      actions: [action ?? const SizedBox.shrink()],
      bottom: bottom,
      centerTitle: centerTitle,
      // elevation: 0,
    );
  }

  static PreferredSize preferredBottom() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(1),
      child: Container(color: AppColorsLight.black, height: 0.5),
    );
  }

  static BoxShadow softShadow({
    Color? color,
    double blurRadius = 10,
    Offset offset = const Offset(0, 4),
  }) {
    return BoxShadow(
      color: color ?? AppColorsLight.textPrimary.withAlpha(30),
      blurRadius: blurRadius,
      offset: offset,
    );
  }

  static void toastMessage({
    required BuildContext context,
    required String message,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 2),
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 80,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextWidget(
                title: message,
                fontSize: 14,
                color: textColor,
                alignment: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );

    // Add to overlay
    overlay.insert(overlayEntry);

    // Remove after duration
    Future.delayed(duration, () {
      overlayEntry.remove();
    });
  }

  static Future<T?> showDialogWidgetWithAnimation<T>({
    required BuildContext context,
    required String title,
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return Navigator.of(context).push<T>(
      PageRouteBuilder<T>(
        opaque: false,
        barrierDismissible: barrierDismissible,
        barrierColor: AppColorsLight.black.withAlpha(200),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: Center(
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(RADIUS),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: TextWidget(title: title, fontSize: 16),
                    ),
                    child,
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOut),
              ),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  static String? validatePhone({
    required String? value,
    required MultiItem country,
    required BuildContext context,
  }) {
    final lang = Localizations.localeOf(context).languageCode;
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    // Remove any non-digit characters for validation
    String cleanedValue = value.replaceAll(RegExp(r'[^\d]'), '');

    RegExp? pattern = phoneValidationPatterns[country.dialCode];
    // print("pattern: $pattern");
    if (pattern != null && !pattern.hasMatch(cleanedValue)) {
      return '${"رقم الهاتف غير صحيح"} ${labelOf(country, lang)}';
    }

    return null;
  }

  static String? validatePassword({
    required String? value,
    String? value2,
    required BuildContext context,
  }) {
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }
    if (value.length < 6) {
      return "كلمة المرور يجب أن تكون 6 أحرف على الأقل";
    }
    if (value2 != null && value != value2) {
      return "كلمة المرور غير متطابقة";
    }
    return null;
  }

  static String? validate({
    required String? value,
    required BuildContext context,
  }) {
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }
    return null;
  }

  /// Validates username to ensure it's in English only and contains no spaces
  static String? validateUsername({
    required String? value,
    required BuildContext context,
  }) {
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    // Check if contains spaces
    if (value.contains(' ')) {
      return 'اسم المستخدم يجب أن لا يحتوي على مسافات';
    }

    // Check if contains only English letters, numbers, and allowed special characters
    // Allowed: letters (a-z, A-Z), numbers (0-9), underscore (_), dot (.)
    final RegExp englishOnly = RegExp(r'^[a-zA-Z0-9_.]+$');
    if (!englishOnly.hasMatch(value)) {
      return 'اسم المستخدم يجب أن يكون بالأحرف الإنجليزية فقط';
    }

    // Optional: Minimum length check
    if (value.length < 3) {
      return 'اسم المستخدم يجب أن يكون 3 أحرف على الأقل';
    }

    return null;
  }

  /// Validates email address format
  static String? validateEmail({
    required String? value,
    required BuildContext context,
  }) {
    if (value == null || value.isEmpty) {
      return "حقل مطلوب";
    }

    // Remove any whitespace
    final trimmedValue = value.trim();

    // Email regex pattern
    // This pattern validates:
    // - Local part: letters, numbers, dots, hyphens, underscores
    // - @ symbol
    // - Domain: letters, numbers, dots, hyphens
    // - TLD: at least 2 letters
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(trimmedValue)) {
      return 'البريد الإلكتروني غير صحيح';
    }

    // Additional validation: check for consecutive dots
    if (trimmedValue.contains('..')) {
      return 'البريد الإلكتروني غير صحيح';
    }

    // Check if starts or ends with dot
    if (trimmedValue.startsWith('.') || trimmedValue.contains('@.')) {
      return 'البريد الإلكتروني غير صحيح';
    }

    return null;
  }

  static Future<void> launchURL({required String url}) async {
    final uri = Uri.tryParse(url);
    if (uri != null) {
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
