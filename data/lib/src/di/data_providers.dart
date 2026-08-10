import 'package:data/src/network/retrofit_service.dart';
import 'package:data/src/repository/product_repository/product_repository_impl.dart';
import 'package:data/src/source/product_data_source/product_ds.dart';
import 'package:data/src/source/product_data_source/product_ds_impl.dart';
import 'package:data/src/util/api_interceptor.dart';
import 'package:data/src/util/network_constant.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod/riverpod.dart';

final apiInterceptorProvider = Provider<ApiInterceptor>((ref) {
  return ApiInterceptor();
});

final interceptorsProvider = Provider<List<Interceptor>>((ref) {
  return <Interceptor>[
    // PrettyDioLogger dumps request/response bodies and headers to the
    // console, which may contain PII/auth tokens. It must never ship to
    // production builds.
    if (!kReleaseMode)
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    ref.watch(apiInterceptorProvider),
  ];
});

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: NetworkConstant.baseUrl,
      connectTimeout: NetworkConstant.connectTimeout,
      sendTimeout: NetworkConstant.sendTimeout,
      receiveTimeout: NetworkConstant.receiveTimeout,
      followRedirects: false,
      validateStatus: (status) =>
          status != null && status >= 200 && status < 300,
    ),
  );
  dio.interceptors.addAll(ref.watch(interceptorsProvider));
  return dio;
});

final retrofitServiceProvider = Provider<RetrofitService>((ref) {
  return RetrofitService(ref.watch(dioProvider));
});

final productDataSourceProvider = Provider<ProductDataSource>((ref) {
  return ProductDataSourceImpl(ref.watch(retrofitServiceProvider));
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(
    productDataSource: ref.watch(productDataSourceProvider),
  );
});
