import 'package:flutter_riverpod_template/core/base/base_view_model/base_state.dart';
import 'package:flutter_riverpod_template/core/base/base_view_model/base_viewmodel.dart';

part 'splash_state.dart';

class SplashViewModel extends BaseViewModel<SplashState> {
  @override
  SplashState build() => const SplashState();
}
