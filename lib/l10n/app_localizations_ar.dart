// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'نهج البلاغة';

  @override
  String get systemLanguage => 'لغة النظام';

  @override
  String get language => 'العربية';

  @override
  String get locale => 'ar_IQ';

  @override
  String get noInternetError =>
      'تعذر إرسال البيانات بسبب عدم وجود اتصال بالإنترنت';

  @override
  String get connectionTimeoutError => 'تعذر الاتصال بالخادم. حاول مرة أخرى.';

  @override
  String get sendTimeoutError =>
      'تعذر إرسال الطلب بالوقت المحدد. حاول مرة أخرى.';

  @override
  String get receiveTimeoutError => 'الخادم تأخر بالرد. حاول مرة أخرى.';

  @override
  String get badCertificateError => 'مشكلة في شهادة الأمان (SSL).';

  @override
  String get cancelError => 'تم إلغاء الطلب.';

  @override
  String get connectionError =>
      'تعذر الاتصال بالخادم. تحقق من الشبكة وحاول مجددًا.';

  @override
  String get unknownError => 'حدث خطأ في الاتصال. حاول مرة أخرى.';

  @override
  String get unauthorizedError => 'يجب تسجيل الدخول أولاً.';

  @override
  String get forbiddenError => 'ليس لديك صلاحية لتنفيذ هذه العملية.';

  @override
  String get notFoundError => 'الطلب غير موجود أو تم حذفه.';

  @override
  String get conflictError => 'يوجد تعارض بالبيانات.';

  @override
  String get unprocessableEntityError => 'البيانات المدخلة غير صحيحة.';

  @override
  String get serverError =>
      'حدث خطأ غير متوقع في النظام. يرجى المحاولة لاحقًا.';

  @override
  String defaultError(Object code) {
    return 'حدث خطأ (Code: $code).';
  }

  @override
  String get socketError => 'تعذر الوصول إلى الخادم. تحقق من الشبكة أو DNS.';
}
