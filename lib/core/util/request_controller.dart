import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

mixin RequestController {
  Future<void> apiCall<T>(
    BaseUseCase<Params, T> createCall, {
    required Params params,
    required void Function(T) onSuccess,
    void Function(NetworkError)? onFailure,
  }) async {
    final result = await createCall.execute(params);
    result.fold(
      (error) => _handleError(error, onFailure),
      (data) => onSuccess(data),
    );
  }

  void _handleError(
    NetworkError error,
    void Function(NetworkError)? onFailure,
  ) {
    if (onFailure != null) {
      onFailure(error);
    } else {
      log(
        '''══════════════════════════════════════════════════════════════════════════════════════════''',
      );
      log(error.message, name: 'RequestController', level: 1000);
      log(
        '''══════════════════════════════════════════════════════════════════════════════════════════''',
      );
    }
  }
}
