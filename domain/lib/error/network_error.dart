import 'package:domain/constants/enum.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/error_info.dart';

import 'base_error.dart';

class NetworkError extends BaseError {
  NetworkError({
    required String message,
    required int httpError,
    ErrorInfo? error,
  }) : super(message, error: error);

  @override
  String getFriendlyMessage() {
    return message;
  }

  @override
  AppError transform() {
    switch (error?.code) {
      case 503:
        return AppError(
            message: error?.message ?? '',
            error: error,
            errorType: AppErrorEnums.NO_INTERNET_CONNECTION);

      case 504:
        return AppError(
            message: error?.message ?? '',
            error: error,
            errorType: AppErrorEnums.INVALID_TEST);

      case 502:
        return AppError(
            message: error?.message ?? '',
            error: error,
            errorType: AppErrorEnums.INVALID_TEST);

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
      message: data.message,
      httpError: data.error?.code ?? 0,
      error: data.error,
    );
  }
}
