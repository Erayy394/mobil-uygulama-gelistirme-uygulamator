import 'package:dio/dio.dart';
import '../../core/constants.dart';
import '../../core/utils/logger.dart';
import '../../core/utils/result.dart';

/// HTTP client service
class HttpClient {
  late final Dio _dio;

  HttpClient() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: Constants.connectTimeout,
        receiveTimeout: Constants.receiveTimeout,
      ),
    );

    // Add interceptors
    _dio.interceptors.add(LogInterceptor(
      requestBody: Constants.enableApiLogging,
      responseBody: Constants.enableApiLogging,
    ));

    // Add auth interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // TODO: Add auth token
        handler.next(options);
      },
      onError: (error, handler) {
        Logger.e('HTTP Error: ${error.message}', error.error);
        handler.next(error);
      },
    ));
  }

  /// GET request
  Future<Result<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return Result.success(response.data as T);
    } catch (e) {
      return Result.failure(e, e.toString());
    }
  }

  /// POST request
  Future<Result<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return Result.success(response.data as T);
    } catch (e) {
      return Result.failure(e, e.toString());
    }
  }

  /// PUT request
  Future<Result<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return Result.success(response.data as T);
    } catch (e) {
      return Result.failure(e, e.toString());
    }
  }

  /// DELETE request
  Future<Result<void>> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      await _dio.delete(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return const Result.success(null);
    } catch (e) {
      return Result.failure(e, e.toString());
    }
  }
}
