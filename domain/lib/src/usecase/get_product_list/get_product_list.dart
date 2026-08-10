import 'package:domain/src/model/error/network_error.dart';
import 'package:domain/src/model/product_list/product_model.dart';
import 'package:domain/src/repository/product_repository/product_repository.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';
import 'package:domain/src/usecase/base/params.dart';
import 'package:twofold/twofold.dart';

class GetProductListUseCase
    extends BaseUseCase<GetProductParams, List<ProductModel>> {
  GetProductListUseCase(this._productRepository);

  final ProductRepository _productRepository;

  @override
  Future<Twofold<List<ProductModel>, NetworkError>> execute(
    GetProductParams params,
  ) {
    return _productRepository.getProducts(params.toJson);
  }
}

class GetProductParams extends Params {
  const GetProductParams({required this.limit});

  final int limit;

  @override
  Map<String, dynamic> get toJson => {'limit': limit};
}
