import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/error_info.dart';
import 'package:retrofit/retrofit.dart';

import 'get_error.dart';

Future<Either<NetworkError, T>> safeApiCall<T>(Future<T> apiCall) async {
  try {
    final originalResponse = await apiCall;
    final eitherResponse = originalResponse as HttpResponse<T>;
    if (!eitherResponse.isSuccessful()) {
      return getError<T>(apiResponse: eitherResponse);
    } else {
      print("original response $originalResponse");
      return Right(originalResponse);
    }
  } catch (throwable) {
    print("Network error: $throwable");
    if (throwable is DioException) {
      switch (throwable.type) {
        case DioExceptionType.connectionTimeout:
          return Left(NetworkError(
              message: "Connection timeout with API server",
              httpError: 408,
              error: ErrorInfo(
                  code: 408, message: "Connection timeout with API server")));
        case DioExceptionType.sendTimeout:
          return Left(NetworkError(
              message: "Send timeout exception",
              httpError: 408,
              error: ErrorInfo(code: 408, message: "Send timeout exception")));
        case DioExceptionType.receiveTimeout:
          return Left(NetworkError(
              message: "Receive timeout in connection with API server",
              httpError: 408,
              error: ErrorInfo(
                  code: 408,
                  message: "Receive timeout in connection with API server")));
        case DioExceptionType.badResponse:
          return Left(NetworkError(
              message:
                  "Received invalid status code: ${throwable.response?.statusCode}",
              httpError: throwable.response?.statusCode ?? 400,
              error: ErrorInfo(
                  code: throwable.response?.statusCode ?? 400,
                  message: "Received invalid status code")));
        case DioExceptionType.cancel:
          return Left(NetworkError(
              message: "Request to API server was cancelled",
              httpError: 499,
              error: ErrorInfo(
                  code: 499, message: "Request to API server was cancelled")));
        case DioExceptionType.unknown:
          return Left(NetworkError(
              message:
                  "Connection to API server failed due to internet connection",
              httpError: 503,
              error: ErrorInfo(
                  code: 503,
                  message:
                      "Connection to API server failed due to internet connection")));
        default:
          return Left(NetworkError(
              message: "Unknown network error",
              httpError: 500,
              error: ErrorInfo(code: 500, message: "Unknown network error")));
      }
    } else if (throwable is IOException) {
      return Left(NetworkError(
          message: throwable.toString(),
          httpError: 502,
          error: ErrorInfo(code: 502, message: throwable.toString())));
    } else if (throwable is HttpException) {
      return Left(NetworkError(
          message: throwable.message,
          httpError: 502,
          error: ErrorInfo(code: 502, message: throwable.message)));
    } else {
      return Left(NetworkError(
          message: throwable.toString(),
          httpError: 502,
          error: ErrorInfo(code: 502, message: throwable.toString())));
    }
  }
}

extension RetrofitResponse on HttpResponse {
  /// Returns true if the code is in [200..300), which means the request was successfully received,
  /// understood, and accepted.
  bool isSuccessful() {
    final statusCode = response.statusCode;
    return statusCode != null && statusCode >= 200 && statusCode < 300;
  }
}
