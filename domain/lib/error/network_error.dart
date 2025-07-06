import 'package:domain/constants/enum.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/error_info.dart';

class NetworkError extends BaseError {
  NetworkError({
    required int httpError,
    required super.cause,
    String message = '',
  }) : super(
         error: ErrorInfo(code: httpError, message: message),
       );

  @override
  String getFriendlyMessage() {
    return error?.message ?? '';
  }

  @override
  AppError transform() {
    switch (error?.code) {
      case 503:
        return AppError(
          message: error?.message ?? '',
          error: error,
          errorType: AppErrorEnums.NO_INTERNET_CONNECTION,
        );

      case 504:
        return AppError(
          message: error?.message ?? '',
          error: error,
          errorType: AppErrorEnums.INVALID_TEST,
        );

      case 502:
        return AppError(
          message: error?.message ?? '',
          error: error,
          errorType: AppErrorEnums.INVALID_TEST,
        );

      default:
        return AppError(
          message: error?.message ?? '',
          error: error,
        );
    }
  }

  @override
  BaseError restore(AppError data) {
    return NetworkError(
      message: data.error?.message ?? '',
      httpError: data.error?.code ?? 0,
      cause: data.cause,
    );
  }
}
