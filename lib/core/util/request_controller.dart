import 'dart:developer';

import 'package:domain/domain.dart';

/// Thin executor that owns the "perform a call, hand me a result" ceremony.
///
/// It guarantees that at most one of [onSuccess]/[onFailure] runs, never both,
/// and that thrown exceptions never escape (they are logged instead of
/// crashing the caller's frame).
mixin RequestController {
  Future<void> apiCall<T>(
    BaseUseCase<Params, T> useCase, {
    required Params params,
    required void Function(T) onSuccess,
    void Function(BaseError)? onFailure,
  }) async {
    var completed = false;

    try {
      final result = await useCase.execute(params);
      result.when(
        onSuccess: (data) {
          if (completed) return;
          completed = true;
          onSuccess(data);
        },
        onError: (error) {
          if (completed) return;
          completed = true;
          log(
            '[$runtimeType] request failed (${error.code})',
            error: error.cause,
            name: 'RequestController',
          );
          onFailure?.call(error);
        },
      );
    } catch (e, stackTrace) {
      // Last line of defence: a defective use-case must not crash the UI.
      log(
        '[$runtimeType] unexpected error while executing $useCase',
        error: e,
        stackTrace: stackTrace,
        name: 'RequestController',
      );
    }
  }
}
