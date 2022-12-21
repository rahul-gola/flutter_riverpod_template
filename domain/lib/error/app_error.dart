import 'package:domain/constants/enum.dart';
import 'package:domain/model/error_info.dart';

import 'base_error.dart';

class AppError extends BaseError {
  AppErrorEnums? errorType;

  AppError({
    required String message,
    Exception? throwable,
    ErrorInfo? error,
    this.errorType,
  }) : super(message, error: error, cause: throwable);

  @override
  String getFriendlyMessage() {
    return message;
  }

  @override
  BaseError restore(AppError data) {
    return AppError(
      message: data.message,
      throwable: data.cause,
      error: data.error,
      errorType: data.errorType,
    );
  }

  @override
  AppError transform() {
    return this;
  }
}
