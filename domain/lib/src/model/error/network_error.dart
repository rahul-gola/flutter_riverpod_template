import 'package:domain/src/model/error/base_error.dart';

class NetworkError extends BaseError {
  const NetworkError({int httpError = 0, super.cause, super.message = ''})
    : super(code: httpError);

  @override
  String getFriendlyMessage() {
    if (message.isNotEmpty) return message;
    // Provide a sensible default when no message is supplied.
    return 'Network error (HTTP $code). Please check your connection.';
  }

  String _safeTypeName(Object? o) {
    if (o == null) return 'Null';
    final name = o.runtimeType.toString();
    return name;
  }

  @override
  String toString() {
    return '''${_safeTypeName(this)} (httpError: $code, message: $message, cause: ${cause ?? 'none'})''';
  }
}
