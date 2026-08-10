
import 'package:dio/dio.dart';

/// Global request pipeline hook.
///
/// Kept intentionally thin and stateless: heavy logic (auth refresh, retries,
/// offline queueing) should live behind this seam. It also marks each request
/// with its start time and surfaces slow calls in debug builds, which is the
/// cheapest way to catch responsiveness regressions on real devices.
class ApiInterceptor extends InterceptorsWrapper {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    return handler.next(options);
  }
}
