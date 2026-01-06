import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_template/core/base/base_view_model/base_state.dart';
import 'package:flutter_riverpod_template/core/util/request_controller.dart';

abstract class BaseViewModel<T extends BaseState> extends Notifier<T>
    with RequestController {
  @override
  T build();

  @protected
  void log(String msg) {
    debugPrint('[$runtimeType] $msg');
  }
}
