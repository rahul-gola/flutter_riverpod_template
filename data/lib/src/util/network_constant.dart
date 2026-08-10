
abstract final class NetworkConstant {
  static const String baseUrl = 'https://dummyjson.com/';
  static const String products = 'products';

  /// Generous but bounded timeouts. On weak mobile connections a phone
  /// silently retrying forever is worse than a fast, user-recoverable error.
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration sendTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
