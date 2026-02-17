import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod_template/core/base/base_view_model/base_state.dart';
import 'package:flutter_riverpod_template/core/base/base_view_model/base_viewmodel.dart';
import 'package:flutter_riverpod_template/core/di/di.dart';

part 'home_state.dart';

class HomeViewModel extends BaseViewModel<HomeState> {
  @override
  HomeState build() => const HomeState();

  @override
  void runBuild() {
    super.runBuild();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final useCase = ref.read(getProductListUseCaseProvider);

    await apiCall<List<ProductModel>>(
      useCase,
      params: GetArticleParams(limit: 1),
      onSuccess: (data) {
        state = state.copyWith(
          isLoading: false,
          products: data,
          clearError: true,
        );
      },
    );
  }
}
