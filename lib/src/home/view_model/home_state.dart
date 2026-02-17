part of 'home_view_model.dart';

class HomeState extends BaseState with EquatableMixin {
  const HomeState({
    this.products = const [],
    this.isLoading = false,
    this.error,
  });

  final List<ProductModel> products;
  final bool isLoading;
  final String? error;

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
