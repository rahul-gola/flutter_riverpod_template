import 'dart:developer';
import 'dart:io';

import 'package:data/src/entity/remote/error/error_entity.dart';
import 'package:data/src/util/base_layer_transformer.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:twofold/twofold.dart';

/// Safely executes an API call and transforms errors into domain
/// [NetworkError] instances so that success and failure share one return type.
///
/// Returns [Twofold.success] with transformed data on success, or
/// [Twofold.error] with a [NetworkError] on failure. The [BaseError] type is
/// intentionally NOT leaked here: callers work against the domain contract.
Future<Twofold<S, NetworkError>> safeApiCall<S>(
  Future<BaseLayerDataTransformer<S>> Function() apiCall,
) async {
  try {
    final response = await apiCall();
    return Twofold.success(response.transform);
  } on DioException catch (e, stackTrace) {
    log(
      'Dio failure for ${e.requestOptions.method} ${e.requestOptions.path}',
      error: e,
      stackTrace: stackTrace,
      name: 'Dio',
    );
    return Twofold.error(_handleDioException(e));
  } on SocketException catch (e, stackTrace) {
    log(
      'Socket exception occurred',
      error: e,
      stackTrace: stackTrace,
      name: 'Network',
    );
    return Twofold.error(
      NetworkError(
        message: 'No internet connection',
        httpError: HttpStatus.serviceUnavailable,
        cause: e,
      ),
    );
  } on IOException catch (e, stackTrace) {
    log(
      'IO exception occurred',
      error: e,
      stackTrace: stackTrace,
      name: 'Network',
    );
    return Twofold.error(
      NetworkError(
        message: 'Network communication failed',
        httpError: HttpStatus.badGateway,
        cause: e,
      ),
    );
  } on FormatException catch (e, stackTrace) {
    log(
      'Data format exception',
      error: e,
      stackTrace: stackTrace,
      name: 'Network',
    );
    return Twofold.error(
      NetworkError(
        message: 'Invalid data format received from server',
        httpError: HttpStatus.unprocessableEntity,
        cause: e,
      ),
    );
  } catch (e, stackTrace) {
    log(
      'Unexpected error in API call',
      error: e,
      stackTrace: stackTrace,
      name: 'Network',
    );
    return Twofold.error(
      NetworkError(
        message: 'An unexpected error occurred',
        httpError: HttpStatus.internalServerError,
        cause: e is Exception ? e : Exception(e.toString()),
      ),
    );
  }
}

/// Maps a [DioException] to a domain [NetworkError].
NetworkError _handleDioException(DioException e) {
  final statusCode = e.response?.statusCode;
  final statusMessage = e.response?.statusMessage;

  // Prefer a server-provided error payload when present.
  if (e.response?.data is Map<String, dynamic>) {
    try {
      final errorEntity = ErrorEntity.fromJson(
        e.response!.data as Map<String, dynamic>,
      );
      return NetworkError(
        message: errorEntity.message,
        httpError: errorEntity.code,
        cause: e,
      );
    } catch (parseError) {
      log('Ignored unusable error payload', error: parseError, name: 'Dio');
    }
  }

  return switch (e.type) {
    DioExceptionType.connectionTimeout => NetworkError(
      message: 'Connection timeout. Please check your internet connection.',
      httpError: HttpStatus.gatewayTimeout,
      cause: e,
    ),
    DioExceptionType.sendTimeout => NetworkError(
      message: 'Request timeout. Please try again.',
      httpError: HttpStatus.gatewayTimeout,
      cause: e,
    ),
    DioExceptionType.receiveTimeout => NetworkError(
      message: 'Server response timeout. Please try again.',
      httpError: HttpStatus.gatewayTimeout,
      cause: e,
    ),
    DioExceptionType.transformTimeout => NetworkError(
      message: 'Response took too long to process. Please try again.',
      httpError: HttpStatus.gatewayTimeout,
      cause: e,
    ),
    DioExceptionType.badCertificate => NetworkError(
      message: 'Security certificate verification failed',
      httpError: HttpStatus.badGateway,
      cause: e,
    ),
    DioExceptionType.badResponse => NetworkError(
      message: statusMessage ?? 'Server returned an error response',
      httpError: statusCode ?? HttpStatus.badRequest,
      cause: e,
    ),
    DioExceptionType.cancel => NetworkError(
      message: 'Request was cancelled',
      httpError: 499, // Client Closed Request
      cause: e,
    ),
    DioExceptionType.connectionError => NetworkError(
      message: 'Failed to connect to server. Please check your internet.',
      httpError: HttpStatus.serviceUnavailable,
      cause: e,
    ),
    DioExceptionType.unknown => NetworkError(
      message: e.message ?? 'An unknown network error occurred',
      httpError: statusCode ?? HttpStatus.internalServerError,
      cause: e,
    ),
  };
}
