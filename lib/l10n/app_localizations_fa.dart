// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appTitle => 'کتابخانه روضه الحیدریه';

  @override
  String get systemLanguage => 'زبان سیستم';

  @override
  String get language => 'فارسی';

  @override
  String get locale => 'fa';

  @override
  String get noInternetError =>
      'ارسال داده‌ها به دلیل عدم اتصال به اینترنت امکان‌پذیر نیست';

  @override
  String get connectionTimeoutError =>
      'اتصال به سرور برقرار نشد. دوباره تلاش کنید.';

  @override
  String get sendTimeoutError =>
      'ارسال درخواست در زمان مقرر انجام نشد. دوباره تلاش کنید.';

  @override
  String get receiveTimeoutError =>
      'سرور در پاسخگویی تاخیر داشت. دوباره تلاش کنید.';

  @override
  String get badCertificateError => 'مشکل در گواهی امنیتی (SSL).';

  @override
  String get cancelError => 'درخواست لغو شد.';

  @override
  String get connectionError =>
      'اتصال به سرور برقرار نشد. شبکه را بررسی کرده و دوباره تلاش کنید.';

  @override
  String get unknownError => 'خطای اتصال رخ داد. دوباره تلاش کنید.';

  @override
  String get unauthorizedError => 'ابتدا باید وارد شوید.';

  @override
  String get forbiddenError => 'شما اجازه انجام این عملیات را ندارید.';

  @override
  String get notFoundError => 'درخواست یافت نشد یا حذف شده است.';

  @override
  String get conflictError => 'تعارض در داده‌ها رخ داد.';

  @override
  String get unprocessableEntityError => 'داده‌های وارد شده صحیح نیست.';

  @override
  String get serverError =>
      'خطای غیرمنتظره‌ای در سیستم رخ داد. لطفاً بعداً تلاش کنید.';

  @override
  String defaultError(Object code) {
    return 'خطایی رخ داد (کد: $code).';
  }

  @override
  String get socketError =>
      'دسترسی به سرور امکان‌پذیر نیست. شبکه یا DNS را بررسی کنید.';
}
