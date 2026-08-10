part of 'home_view_model.dart';

class HomeState extends BaseState with Equatable {
  const HomeState({
    this.products = const [],
    this.isLoading = false,
    this.error,
  });

  final List<ProductModel> products;
  final bool isLoading;
  final String? error;

  bool get hasError => error != null;

  HomeState copyWith({
    List<ProductModel>? products,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return HomeState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }

  @override
  List<Object?> get props => [products, isLoading, error];
}
