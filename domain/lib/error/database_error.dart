import 'package:domain/constants/enum.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/error/base_error.dart';

class DatabaseError extends BaseError {
  DatabaseError({
    required this.message,
    super.error,
    Exception? cause,
  }) : super(cause: cause ?? Exception(message));

  final String message;

  @override
  String getFriendlyMessage() {
    return error?.message ?? '';
  }

  @override
  AppError transform() {
    switch (error?.code) {
      case 1:
        return AppError(
          message: error?.message ?? '',
          error: error,
          errorType: AppErrorEnums.DB_ERROR,
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
    return DatabaseError(
      message: data.message,
      error: data.error,
    );
  }
}
