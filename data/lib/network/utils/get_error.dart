import 'package:dartz/dartz.dart';
import 'package:data/entity/remote/error/error_response_entity.dart';
import 'package:domain/error/network_error.dart';
import 'package:domain/model/error_info.dart';
import 'package:retrofit/retrofit.dart';

Either<NetworkError, T> getError<T>({required HttpResponse<T> apiResponse}) {
  if (apiResponse.data != null) {
    try {
      final errorResponseEntity = ErrorResponseEntity.fromJson(
          apiResponse.data as Map<String, dynamic>);
      if (errorResponseEntity != null) {
        return Left(NetworkError(
            httpError: apiResponse.response.statusCode ?? 0,
            message: errorResponseEntity.error.message ?? '',
            error: ErrorInfo(code: apiResponse.response.statusCode)));
      } else {
        return Left(NetworkError(
            httpError: apiResponse.response.statusCode ?? 0,
            error: ErrorInfo(code: apiResponse.response.statusCode),
            message: apiResponse.response.statusMessage ?? ''));
      }
    } catch (exception) {
      return Left(NetworkError(
          error: ErrorInfo(code: apiResponse.response.statusCode),
          httpError: apiResponse.response.statusCode ?? 0,
          message: apiResponse.response.statusMessage ?? ''));
    }
  } else {
    return Left(NetworkError(
        error: ErrorInfo(code: apiResponse.response.statusCode),
        httpError: apiResponse.response.statusCode ?? 0,
        message: apiResponse.response.statusMessage ?? ''));
  }
}
