import 'package:domain/error/app_error.dart';
import 'package:domain/model/error_info.dart';
import 'package:domain/utils/mapper/base_layer_data_tranformer.dart';

abstract class BaseError extends BaseLayerDataTransformer<BaseError, AppError>
    implements Exception {
  BaseError({required this.error, required this.cause});

  final ErrorInfo? error;
  final Exception cause;

  String getFriendlyMessage();

  void logError() {}
}
