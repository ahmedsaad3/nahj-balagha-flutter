import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:nahj_balagha_flutter/core/network/error_message_model.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/utils/router/app_routes.dart';
import 'package:nahj_balagha_flutter/extensions/context_extensions.dart';
import 'package:nahj_balagha_flutter/l10n/app_localizations.dart';

class DioErrorMapper {
  static AppLocalizations? get _l10n {
    final context = AppRoutes.navigatorKey.currentContext;
    if (context != null) {
      return context.localizations;
    }
    return null;
  }

  static Future<Failure> map(DioException e) async {
    final l10n = _l10n;

    if (!await _hasInternetConnection()) {
      return Failure(
        response: ErrorMessageModel(
          message:
              l10n?.noInternetError ??
              'تعذر إرسال البيانات بسبب عدم وجود اتصال بالإنترنت',
        ),
      );
    }
    if (e.response == null) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
          return Failure(
            response: ErrorMessageModel(
              message:
                  l10n?.connectionTimeoutError ??
                  'تعذر الاتصال بالخادم. حاول مرة أخرى.',
              statusCode: 408,
            ),
          );

        case DioExceptionType.sendTimeout:
          return Failure(
            response: ErrorMessageModel(
              message:
                  l10n?.sendTimeoutError ??
                  'تعذر إرسال الطلب بالوقت المحدد. حاول مرة أخرى.',
              statusCode: 408,
            ),
          );

        case DioExceptionType.receiveTimeout:
          return Failure(
            response: ErrorMessageModel(
              message:
                  l10n?.receiveTimeoutError ??
                  'الخادم تأخر بالرد. حاول مرة أخرى.',
              statusCode: 408,
            ),
          );

        case DioExceptionType.badCertificate:
          return Failure(
            response: ErrorMessageModel(
              message:
                  l10n?.badCertificateError ?? 'مشكلة في شهادة الأمان (SSL).',
              statusCode: 408,
            ),
          );

        case DioExceptionType.cancel:
          return Failure(
            response: ErrorMessageModel(
              message: l10n?.cancelError ?? 'تم إلغاء الطلب.',
            ),
          );

        case DioExceptionType.connectionError:
          return Failure(
            response: ErrorMessageModel(
              message:
                  l10n?.connectionError ??
                  'تعذر الاتصال بالخادم. تحقق من الشبكة وحاول مجددًا.',
              statusCode: 408,
            ),
          );

        case DioExceptionType.unknown:
        default:
          return Failure(
            response: ErrorMessageModel(
              message: _bestMessageFromUnknown(e, l10n),
              statusCode: 408,
            ),
          );
      }
    }

    final status = e.response?.statusCode ?? 0;

    if (status == 401) {
      return Failure(
        response: ErrorMessageModel(
          message:
              e.response?.data ??
              l10n?.unauthorizedError ??
              'يجب تسجيل الدخول أولاً.',
          statusCode: 401,
        ),
      );
    }
    if (status == 403) {
      return Failure(
        response: ErrorMessageModel(
          message:
              l10n?.forbiddenError ?? 'ليس لديك صلاحية لتنفيذ هذه العملية.',
          statusCode: 403,
        ),
      );
    }
    if (status == 404) {
      return Failure(
        response: ErrorMessageModel(
          message: l10n?.notFoundError ?? 'الطلب غير موجود أو تم حذفه.',
          statusCode: 404,
        ),
      );
    }
    if (status == 409) {
      return Failure(
        response: ErrorMessageModel(
          message: l10n?.conflictError ?? 'يوجد تعارض بالبيانات.',
          statusCode: 409,
        ),
      );
    }
    if (status == 422 || status == 400) {
      return Failure(
        response:
            _tryParseServerMessage(e.response?.data) ??
            ErrorMessageModel(
              message:
                  l10n?.unprocessableEntityError ??
                  'البيانات المدخلة غير صحيحة.',
              statusCode: 400,
            ),
      );
    }
    if (status >= 500) {
      return Failure(
        response: ErrorMessageModel(
          message:
              l10n?.serverError ??
              'حدث خطأ غير متوقع في النظام. يرجى المحاولة لاحقًا.',
          statusCode: 500,
        ),
      );
    }

    return Failure(
      response:
          _tryParseServerMessage(e.response?.data) ??
          ErrorMessageModel(
            message:
                l10n?.defaultError(status.toString()) ??
                'حدث خطأ (Code: $status).',
          ),
    );
  }

  static ErrorMessageModel? _tryParseServerMessage(dynamic data) {
    try {
      if (data is String && data.trim().isNotEmpty) {
        return ErrorMessageModel(message: data);
      }
      if (data is Map && data.containsKey('message')) {
        return ErrorMessageModel(message: data['message'].toString());
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  static String _bestMessageFromUnknown(
    DioException e,
    AppLocalizations? l10n,
  ) {
    final msg = e.message ?? '';
    if (msg.contains('SocketException') || msg.contains('Failed host lookup')) {
      return l10n?.socketError ??
          'تعذر الوصول إلى الخادم. تحقق من الشبكة أو DNS.';
    }
    return l10n?.unknownError ?? 'حدث خطأ في الاتصال. حاول مرة أخرى.';
  }

  static Future<bool> _hasInternetConnection() async {
    final result = await Connectivity().checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }
}
