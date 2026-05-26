import 'package:dio/dio.dart';
import 'package:nahj_balagha_flutter/core/network/dio_error_mapper.dart';
import 'package:nahj_balagha_flutter/core/network/error_message_model.dart';
import 'package:nahj_balagha_flutter/core/network/isolate_parser.dart';
import 'package:nahj_balagha_flutter/core/network/result.dart';
import 'package:nahj_balagha_flutter/core/services/services_locator.dart';
import 'package:nahj_balagha_flutter/core/utils/constant.dart';
import 'package:nahj_balagha_flutter/core/utils/typedef.dart';
import 'package:nahj_balagha_flutter/features/auth/data/repository/token_repository.dart';
import 'package:nahj_balagha_flutter/features/auth/presentation/controller/auth_cubit/auth_cubit.dart';

class DioClient {
  TokenRepository tokenRepository;
  DioClient({required this.tokenRepository});

  String? _token;
  Dio dio({bool isAuth = false}) {
    if (isAuth) {
      _token = tokenRepository.getToken();
    }
    final dio = _createDio(isAuth: isAuth);
    return dio;
  }

  Dio _createDio({bool isAuth = false}) =>
      Dio(
          BaseOptions(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              if (_token != null) ...{'Authorization': "Bearer $_token"},
            },
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 15),
            validateStatus: (status) =>
                status != null && status >= 200 && status < 300,
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onError: (e, handler) {
              if (e.response?.statusCode == 401) {
                final authCubit = sl<AuthCubit>();
                if (!authCubit.state.isGuest) {
                  authCubit.logout();
                }
              }
              return handler.next(e);
            },
          ),
        );

  Future<Result<T>> _processResponse<T>({
    required Future<Response> responseAsync,
    required ResponseConverter<T> converter,
    bool isIsolate = true,
    List<int> successCodes = const [STATUS_OK, 201],
  }) async {
    try {
      final response = await responseAsync;
      print("pProcess Response statusCode ${response.statusCode}");
      print("pProcess Response data ${response.data}");
      // Check if status code is in the success range
      if (!successCodes.contains(response.statusCode)) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      if (!isIsolate) {
        return Success<T>(response: converter(response.data));
      }
      final isolateParse = IsolateParser<T>(response.data, converter);

      final result = await isolateParse.parseInBackground();

      return Success<T>(response: result);
    } on DioException catch (e) {
      print("Dio Exception $e");
      final failure = await DioErrorMapper.map(e);
      return Failure<T>(code: failure.code, response: failure.response as T?);
    } catch (e) {
      print("catch ${e.toString()}");
      return Failure<T>(
        response: ErrorMessageModel(message: e.toString(), statusCode: 400) as T?,
      );
    }
  }

  // POST request
  Future<Result<T>> postRequest<T>({
    required String url,
    required ResponseConverter<T> converter,
    Map<String, dynamic>? data,
    bool isIsolate = true,
    Map<String, dynamic>? queryParameters,
    bool isAuth = false,
  }) async {
    return _processResponse<T>(
      responseAsync: dio(
        isAuth: isAuth,
      ).post(url, data: data, queryParameters: queryParameters),
      converter: converter,
      isIsolate: isIsolate,
    );
  }

  /// POST request with Form-Data (multipart/form-data)
  Future<Result<T>> postFormDataRequest<T>({
    required String url,
    required ResponseConverter<T> converter,
    required Map<String, dynamic> data,
    bool isIsolate = true,
    Map<String, dynamic>? queryParameters,
    bool isAuth = false,
  }) async {
    final formData = FormData.fromMap(data);
    return _processResponse<T>(
      responseAsync: dio(isAuth: isAuth).post(
        url,
        data: formData,
        queryParameters: queryParameters,
        options: Options(contentType: 'multipart/form-data'),
      ),
      converter: converter,
      isIsolate: isIsolate,
    );
  }

  /// GET request (fetch)
  Future<Result<T>> getRequest<T>({
    required String url,
    required ResponseConverter<T> converter,
    Map<String, dynamic>? queryParameters,
    bool isIsolate = true,
    bool isAuth = false,
  }) async {
    return _processResponse<T>(
      responseAsync: dio(
        isAuth: isAuth,
      ).get(url, queryParameters: queryParameters),
      converter: converter,
      isIsolate: isIsolate,
      successCodes: [STATUS_OK],
    );
  }

  // PUT request
  Future<Result<T>> putRequest<T>({
    required String url,
    required ResponseConverter<T> converter,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    bool isIsolate = true,
    bool isAuth = false,
  }) async {
    return _processResponse<T>(
      responseAsync: dio(
        isAuth: isAuth,
      ).put(url, data: data, queryParameters: queryParameters),
      converter: converter,
      isIsolate: isIsolate,
    );
  }

  /// PUT request with Form-Data (multipart/form-data)
  Future<Result<T>> putFormDataRequest<T>({
    required String url,
    required ResponseConverter<T> converter,
    required Map<String, dynamic> data,
    bool isIsolate = true,
    Map<String, dynamic>? queryParameters,
    bool isAuth = false,
  }) async {
    final formData = FormData.fromMap(data);

    return _processResponse<T>(
      responseAsync: dio(isAuth: isAuth).put(
        url,
        data: formData,
        queryParameters: queryParameters,
        options: Options(contentType: 'multipart/form-data'),
      ),
      converter: converter,
      isIsolate: isIsolate,
    );
  }
}
