import 'package:data/src/network/retrofit_service.dart';
import 'package:data/src/repository/product_repository/product_repository_impl.dart';
import 'package:data/src/source/product_data_source/product_ds.dart';
import 'package:data/src/source/product_data_source/product_ds_impl.dart';
import 'package:data/src/util/api_interceptor.dart';
import 'package:data/src/util/network_constant.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod/riverpod.dart';

final prettyDioLoggerProvider = Provider<PrettyDioLogger>((ref) {
  return PrettyDioLogger(
    requestBody: true,
    requestHeader: true,
    responseHeader: true,
  );
});

final apiInterceptorProvider = Provider<ApiInterceptor>((ref) {
  return ApiInterceptor();
});

final interceptorsProvider = Provider<List<Interceptor>>((ref) {
  return <Interceptor>[
    ref.watch(prettyDioLoggerProvider),
    ref.watch(apiInterceptorProvider),
  ];
});

final dioProvider = Provider<Dio>((ref) {
  const baseUrl = NetworkConstant.baseUrl;
  final dio = Dio(BaseOptions(baseUrl: baseUrl));
  dio.interceptors.addAll(ref.watch(interceptorsProvider));
  return dio;
});

final retrofitServiceProvider = Provider<RetrofitService>((ref) {
  return RetrofitService(ref.watch(dioProvider));
});

final productDataSourceProvider = Provider<ProductDataSource>((ref) {
  return ArticleDataSourceImpl(ref.watch(retrofitServiceProvider));
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(
    articleDataSource: ref.watch(productDataSourceProvider),
  );
});
