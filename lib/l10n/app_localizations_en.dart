// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Nahj al-Balagha';

  @override
  String get systemLanguage => 'System Language';

  @override
  String get language => 'English';

  @override
  String get locale => 'en';

  @override
  String get noInternetError =>
      'Could not send data because there is no internet connection';

  @override
  String get connectionTimeoutError =>
      'Could not connect to the server. Try again.';

  @override
  String get sendTimeoutError => 'Could not send request in time. Try again.';

  @override
  String get receiveTimeoutError => 'Server delayed in responding. Try again.';

  @override
  String get badCertificateError => 'SSL security certificate problem.';

  @override
  String get cancelError => 'Request was cancelled.';

  @override
  String get connectionError =>
      'Could not connect to the server. Check network and try again.';

  @override
  String get unknownError => 'Connection error occurred. Try again.';

  @override
  String get unauthorizedError => 'You must log in first.';

  @override
  String get forbiddenError =>
      'You do not have permission to perform this operation.';

  @override
  String get notFoundError => 'Request not found or has been deleted.';

  @override
  String get conflictError => 'Data conflict occurred.';

  @override
  String get unprocessableEntityError => 'Input data is incorrect.';

  @override
  String get serverError =>
      'An unexpected system error occurred. Please try later.';

  @override
  String defaultError(Object code) {
    return 'An error occurred (Code: $code).';
  }

  @override
  String get socketError => 'Could not reach the server. Check network or DNS.';
}
