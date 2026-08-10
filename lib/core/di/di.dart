import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_template/src/home/view_model/home_view_model.dart';
import 'package:flutter_riverpod_template/src/splash_screen/view_model/splash_view_model.dart';

/// Composition root for presentation-layer providers.
abstract final class DI {
  static final getProductListUseCaseProvider = Provider<GetProductListUseCase>((ref) {
    return GetProductListUseCase(ref.watch(productRepositoryProvider));
  });

  static final homeVMProvider = NotifierProvider<HomeViewModel, HomeState>(
    HomeViewModel.new,
    isAutoDispose: true,
  );

  static final splashVMProvider = NotifierProvider<SplashViewModel, SplashState>(
    SplashViewModel.new,
    isAutoDispose: true,
  );
}
