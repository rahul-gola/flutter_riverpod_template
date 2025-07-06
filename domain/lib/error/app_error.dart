import 'package:domain/constants/enum.dart';
import 'package:domain/error/base_error.dart';
import 'package:domain/model/error_info.dart';

class AppError extends BaseError {
  AppError({
    required this.message,
    Exception? throwable,
    ErrorInfo? error,
    this.errorType,
  }) : super(
         error: error ?? ErrorInfo(message: message),
         cause: throwable ?? Exception(),
       );
  AppErrorEnums? errorType;
  final String message;

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
