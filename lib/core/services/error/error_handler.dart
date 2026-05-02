import 'package:dio/dio.dart';

import 'error_types.dart';
import 'failure.dart';

class ErrorHandler {
  Failure handle(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    }
    return Failure.unknown;
  }

  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const Failure(message: 'Request timed out', statusCode: 408);

      case DioExceptionType.cancel:
        return const Failure(message: 'Request cancelled', statusCode: 0);

      case DioExceptionType.connectionError:
        return Failure.network;

      case DioExceptionType.badResponse:
        return _handleStatusCode(error.response?.statusCode);

      default:
        return Failure.unknown;
    }
  }

  Failure _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return const Failure(message: 'Bad request', statusCode: 400);
      case 401:
        return Failure.unauthorized;
      case 403:
        return const Failure(message: 'Forbidden', statusCode: 403);
      case 404:
        return const Failure(message: 'Resource not found', statusCode: 404);
      case 422:
        return const Failure(message: 'Validation error', statusCode: 422);
      case 500:
        return const Failure(message: 'Server error', statusCode: 500);
      default:
        return Failure.unknown;
    }
  }

  ErrorType classifyError(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionError) {
        return ErrorType.network;
      }
      if (error.response?.statusCode == 401) return ErrorType.unauthorized;
      if (error.response?.statusCode == 404) return ErrorType.notFound;
      if (error.response != null &&
          error.response!.statusCode! >= 500) {
        return ErrorType.serverError;
      }
    }
    return ErrorType.unknown;
  }
}