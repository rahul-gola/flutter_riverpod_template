import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_template/core/base/base_view_model/base_state.dart';
import 'package:flutter_riverpod_template/core/util/request_controller.dart';

abstract class BaseViewModel<T extends BaseState> extends Notifier<T>
    with RequestController {
  @override
  T build();

  /// Whether the provider has been disposed. Async work in a `Notifier` must
  /// stop touching `state` once this returns `true`, otherwise Riverpod throws
  /// `StateError: Cannot use a disposed provider`.
  bool get isDisposed => !ref.mounted;

  /// Replaces [state] with [newState], but only while the provider is alive.
  ///
  /// This is the only safe way to update state from an async callback.
  void emit(T newState) {
    if (!isDisposed) state = newState;
  }

  @protected
  void log(String msg) {
    debugPrint('[$runtimeType] $msg');
  }
}
