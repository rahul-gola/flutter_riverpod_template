import 'package:domain/model/error_info.dart';
import 'package:domain/utils/mapper/base_layer_data_tranformer.dart';

import 'app_error.dart';

abstract class BaseError
    with BaseLayerDataTransformer<BaseError, AppError>
    implements Exception {
  final String message;
  ErrorInfo? error;
  Exception? cause;

  BaseError(this.message, {this.error, this.cause});

  String getFriendlyMessage();

  logError() {
    // TODO: Logging to crashlytics
  }
}
