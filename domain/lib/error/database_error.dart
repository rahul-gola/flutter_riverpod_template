import 'package:domain/constants/enum.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/error_info.dart';

import 'base_error.dart';

class DatabaseError extends BaseError {
  DatabaseError({
    required String message,
    ErrorInfo? error,
  }) : super(message, error: error);

  @override
  String getFriendlyMessage() {
    return message;
  }

  @override
  AppError transform() {
    switch (error?.code) {
      case 1:
        return AppError(
            message: error?.message ?? '',
            error: error,
            errorType: AppErrorEnums.DB_ERROR);

      default:
        return AppError(
          message: error?.message ?? '',
          error: error,
        );
    }
  }

  @override
  BaseError restore(AppError data) {
    return DatabaseError(
      message: data.message,
      error: data.error,
    );
  }
}
