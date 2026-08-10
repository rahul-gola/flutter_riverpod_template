import 'package:data/src/source/product_data_source/product_ds.dart';
import 'package:data/src/util/safe_api_call.dart';
import 'package:domain/domain.dart';
import 'package:twofold/twofold.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({required this.productDataSource});

  final ProductDataSource productDataSource;

  @override
  Future<Twofold<List<ProductModel>, NetworkError>> getProducts(
    Map<String, dynamic> queries,
  ) {
    return safeApiCall<List<ProductModel>>(
      () => productDataSource.getProductList(queries),
    );
  }
}
