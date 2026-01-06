import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_template/src/home/view_model/home_view_model.dart';
import 'package:flutter_riverpod_template/src/home/view_model/state/home_state.dart';

final getProductListUseCaseProvider = Provider<GetProductListUseCase>((ref) {
  return GetProductListUseCase(ref.watch(productRepositoryProvider));
});

final NotifierProvider<HomeViewModel, HomeState> homeViewModelProvider =
    NotifierProvider<HomeViewModel, HomeState>(
      HomeViewModel.new,
      isAutoDispose: true,
    );
