import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_client.dart';
import 'endpoints.dart';

class DioClient implements ApiClient {
  DioClient(this._dio) {
    _dio
      ..options = BaseOptions(
        baseUrl: Endpoints.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      )
      ..interceptors.addAll([
        _AuthInterceptor(),
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
        ),
      ]);
  }

  final Dio _dio;

  @override
  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    final response = await _dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return response.data;
  }

  @override
  Future<dynamic> post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    final response = await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return response.data;
  }

  @override
  Future<dynamic> put(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    final response = await _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return response.data;
  }

  @override
  Future<dynamic> patch(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    final response = await _dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return response.data;
  }

  @override
  Future<dynamic> delete(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    final response = await _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
    return response.data;
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Token injection handled here — CacheClient accessed via GetIt in real impl
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // TODO: trigger token refresh or logout
    }
    handler.next(err);
  }
}