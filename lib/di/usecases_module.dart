import 'package:data/di/data_module.dart';
import 'package:domain/usecase/fetch_province.dart';
import 'package:domain/usecase/fetch_update_province.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final provinceFetchUseCase = Provider<FetchProvinceUseCase>(
  (ref) {
    return FetchProvinceUseCase(ref.read(provinceDataRepositoryProvider));
  },
);

final provinceFetchAndUpdateUseCase = Provider<FetchUpdateProvinceUseCase>(
  (ref) {
    return FetchUpdateProvinceUseCase(ref.read(provinceDataRepositoryProvider));
  },
);
