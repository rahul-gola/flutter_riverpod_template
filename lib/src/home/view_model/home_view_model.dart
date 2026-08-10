import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod_template/core/base/base_view_model/base_state.dart';
import 'package:flutter_riverpod_template/core/base/base_view_model/base_viewmodel.dart';
import 'package:flutter_riverpod_template/core/di/di.dart';

part 'home_state.dart';

class HomeViewModel extends BaseViewModel<HomeState> {
  static const int _pageSize = 20;

  @override
  HomeState build() {
    Future.microtask(fetchProducts);
    return const HomeState();
  }


  Future<void> retry() => fetchProducts();

  Future<void> fetchProducts() async {
    if (isDisposed || state.isLoading) return;

    emit(state.copyWith(isLoading: true, clearError: true));

    final useCase = ref.read(DI.getProductListUseCaseProvider);

    await apiCall<List<ProductModel>>(
      useCase,
      params: const GetProductParams(limit: _pageSize),
      onSuccess: (data) {
        if (isDisposed) return;
        emit(
          state.copyWith(isLoading: false, products: data, clearError: true),
        );
      },
      onFailure: (error) {
        if (isDisposed) return;
        emit(
          state.copyWith(isLoading: false, error: error.getFriendlyMessage()),
        );
      },
    );
  }
}
